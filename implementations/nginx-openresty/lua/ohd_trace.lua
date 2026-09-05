local random = require "resty.random"
local str = require "resty.string"

local _M = {}

local ZERO_TRACE_ID = string.rep("0", 32)
local ZERO_PARENT_ID = string.rep("0", 16)

local function random_hex(bytes)
    local value, err = random.bytes(bytes, true)
    if not value then
        return nil, err or "unable to generate secure random bytes"
    end
    return str.to_hex(value)
end

local function parse_v00_traceparent(value)
    if type(value) ~= "string" then
        return nil
    end

    local version, trace_id, parent_id, flags = value:match(
        "^([0-9a-f][0-9a-f])%-([0-9a-f]+)%-([0-9a-f]+)%-([0-9a-f][0-9a-f])$"
    )

    if version ~= "00" or #trace_id ~= 32 or #parent_id ~= 16 then
        return nil
    end
    if trace_id == ZERO_TRACE_ID or parent_id == ZERO_PARENT_ID then
        return nil
    end

    return {
        version = version,
        trace_id = trace_id,
        parent_id = parent_id,
        flags = flags,
    }
end

local function create_context()
    local trace_id, trace_err = random_hex(16)
    if not trace_id then
        return nil, trace_err
    end
    local parent_id, parent_err = random_hex(8)
    if not parent_id then
        return nil, parent_err
    end

    return {
        version = "00",
        trace_id = trace_id,
        parent_id = parent_id,
        flags = "00",
        source = "generated",
    }
end

function _M.access()
    local incoming = ngx.var.http_traceparent
    local incoming_ohd = ngx.var.http_ohd_trace_id
    local parsed = parse_v00_traceparent(incoming)
    local context

    if parsed then
        local outgoing_parent, err = random_hex(8)
        if not outgoing_parent then
            ngx.log(ngx.ERR, "OHD failed to create outgoing parent ID: ", err)
            return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
        end
        context = {
            version = parsed.version,
            trace_id = parsed.trace_id,
            parent_id = outgoing_parent,
            flags = parsed.flags,
            source = "incoming",
        }
    else
        local err
        context, err = create_context()
        if not context then
            ngx.log(ngx.ERR, "OHD failed to establish Trace Context: ", err)
            return ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
        end
    end

    ngx.ctx.ohd = context
    ngx.var.ohd_trace_id = context.trace_id
    ngx.var.ohd_trace_source = context.source
    ngx.var.ohd_trace_id_mismatch = (incoming_ohd and incoming_ohd ~= context.trace_id) and "true" or "false"

    local outgoing_traceparent = table.concat({
        context.version,
        context.trace_id,
        context.parent_id,
        context.flags,
    }, "-")

    ngx.req.set_header("traceparent", outgoing_traceparent)
    ngx.req.set_header("OHD-Trace-ID", context.trace_id)
end

function _M.header_filter()
    local context = ngx.ctx.ohd
    if context and context.trace_id then
        ngx.header["OHD-Trace-ID"] = context.trace_id
    end
end

return _M
