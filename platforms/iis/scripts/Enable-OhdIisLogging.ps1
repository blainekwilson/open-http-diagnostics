[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$SiteName = "Default Web Site",
    [switch]$IncludeTraceState
)

$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop

$site = Get-Website -Name $SiteName -ErrorAction Stop
$filter = "system.applicationHost/sites/site[@name='$SiteName']/logFile/customFields"

function Add-CustomFieldIfMissing {
    param([string]$LogFieldName, [string]$SourceName)

    $existing = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$filter/add" -Name '.' |
        Where-Object { $_.logFieldName -eq $LogFieldName }

    if (-not $existing) {
        if ($PSCmdlet.ShouldProcess($SiteName, "Add IIS custom log field $LogFieldName")) {
            Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $filter -Name '.' -Value @{
                logFieldName = $LogFieldName
                sourceName   = $SourceName
                sourceType   = 'RequestHeader'
            }
        }
    }
}

Add-CustomFieldIfMissing -LogFieldName 'traceparent' -SourceName 'traceparent'
if ($IncludeTraceState) {
    Add-CustomFieldIfMissing -LogFieldName 'tracestate' -SourceName 'tracestate'
}

Write-Host "OHD Trace Context logging configured for IIS site '$SiteName'."
