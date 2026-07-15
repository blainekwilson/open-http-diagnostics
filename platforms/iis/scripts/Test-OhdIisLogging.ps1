[CmdletBinding()]
param([string]$SiteName = "Default Web Site")

$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop
$filter = "system.applicationHost/sites/site[@name='$SiteName']/logFile/customFields/add"
$fields = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $filter -Name '.'

$traceParent = $fields | Where-Object { $_.logFieldName -eq 'traceparent' -and $_.sourceName -eq 'traceparent' }
$traceState = $fields | Where-Object { $_.logFieldName -eq 'tracestate' -and $_.sourceName -eq 'tracestate' }

[pscustomobject]@{
    SiteName          = $SiteName
    TraceParentLogged = [bool]$traceParent
    TraceStateLogged  = [bool]$traceState
}
