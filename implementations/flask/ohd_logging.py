from __future__ import annotations

from datetime import datetime, timezone
from time import perf_counter
from typing import Iterable
from typing import Callable
from typing import Optional
from typing import TextIO

OHD_FIELDS = (
    "timestamp",
    "client_ip",
    "method",
    "host",
    "path",
    "status",
    "duration",
    "traceparent",
    "tracestate",
    "ohd_trace_id",
    "query",
    "protocol",
    "bytes_sent",
    "referer",
    "user_agent",
)


def _value(environ: dict, header: str) -> str:
    if header == "OHD-Trace-ID":
        key = "HTTP_OHD_TRACE_ID"
    else:
        key = "HTTP_" + header.upper().replace("-", "_")
    return environ.get(key, "-") or "-"


def _clean(value: object) -> str:
    return str(value).replace("\t", " ").replace("\r", " ").replace("\n", " ") or "-"


class OHDLogMiddleware:
    def __init__(self, application: Callable, log_path: str):
        self.application = application
        self.log_path = log_path

    def __call__(self, environ: dict, start_response: Callable):
        started = perf_counter()
        response_status: Optional[str] = None
        response_headers: list[tuple[str, str]] = []

        def capture_status(status: str, headers: list[tuple[str, str]], exc_info=None):
            nonlocal response_status, response_headers
            response_status = status
            response_headers = headers
            return start_response(status, headers, exc_info)

        body: Iterable[bytes] = self.application(environ, capture_status)
        total_bytes = 0
        try:
            for chunk in body:
                total_bytes += len(chunk)
                yield chunk
        finally:
            close = getattr(body, "close", None)
            if close is not None:
                close()
            self._write_record(environ, response_status or "500", total_bytes, started)

    def _write_record(self, environ: dict, status: str, total_bytes: int, started: float):
        timestamp = datetime.now(timezone.utc).isoformat(timespec="seconds")
        duration = f"{perf_counter() - started:.6f}"
        status_code = status.split(" ", 1)[0]
        values = (
            timestamp,
            environ.get("REMOTE_ADDR", "-") or "-",
            environ.get("REQUEST_METHOD", "-") or "-",
            environ.get("HTTP_HOST", "-") or "-",
            environ.get("PATH_INFO", "-") or "-",
            status_code,
            duration,
            _value(environ, "traceparent"),
            _value(environ, "tracestate"),
            _value(environ, "OHD-Trace-ID"),
            environ.get("QUERY_STRING", "-") or "-",
            environ.get("SERVER_PROTOCOL", "-") or "-",
            total_bytes,
            environ.get("HTTP_REFERER", "-") or "-",
            environ.get("HTTP_USER_AGENT", "-") or "-",
        )
        with open(self.log_path, "a", encoding="utf-8") as stream:
            stream.write("\t".join(_clean(value) for value in values) + "\n")
