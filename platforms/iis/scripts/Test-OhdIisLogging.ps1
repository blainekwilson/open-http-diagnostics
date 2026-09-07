[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SiteName = 'Default Web Site',

    [Parameter()]
    [switch]$FailOnNonConformance
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop
Get-Website -Name $SiteName -ErrorAction Stop | Out-Null

$siteFilter = "system.applicationHost/sites/site[@name='$SiteName']"
$logFormatValue = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$siteFilter/logFile" -Name 'logFormat'
if ($logFormatValue.PSObject.Properties['Value']) {
     $logFormat = [string]$logFormatValue.Value
}
else {
     $logFormat = [string]$logFormatValue
}
$fields = @(Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$siteFilter/logFile/customFields/add" -Name '.' -ErrorAction SilentlyContinue)

$expected = @(
    @{ LogFieldName = 'traceparent';  SourceName = 'traceparent' },
    @{ LogFieldName = 'tracestate';   SourceName = 'tracestate' },
    @{ LogFieldName = 'ohd_trace_id'; SourceName = 'OHD-Trace-ID' }
)

$checks = foreach ($item in $expected) {
    $match = $fields | Where-Object {
        [string]$_.logFieldName -ieq $item.LogFieldName -and
        [string]$_.sourceName -ieq $item.SourceName -and
        [string]$_.sourceType -ieq 'RequestHeader'
    }
    [pscustomobject]@{
        Field       = $item.LogFieldName
        Source      = $item.SourceName
        Configured  = [bool]$match
    }
}

$result = [pscustomobject]@{
    SiteName          = $SiteName
    LogFormat         = $logFormat
    UsesW3C           = ($logFormat -eq 'W3C')
    TraceParentLogged = [bool]($checks | Where-Object Field -eq 'traceparent').Configured
    TraceStateLogged  = [bool]($checks | Where-Object Field -eq 'tracestate').Configured
    OhdTraceIdLogged  = [bool]($checks | Where-Object Field -eq 'ohd_trace_id').Configured
    Conforms          = ($logFormat -eq 'W3C' -and -not ($checks.Configured -contains $false))
}

$result
$checks | Format-Table -AutoSize

if ($FailOnNonConformance -and -not $result.Conforms) {
    throw "IIS site '$SiteName' does not conform to the OHD Level 1 custom-field requirements."
}
