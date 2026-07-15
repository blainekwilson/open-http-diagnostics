[CmdletBinding(SupportsShouldProcess)]
param([string]$SiteName = "Default Web Site")

$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop
$filter = "system.applicationHost/sites/site[@name='$SiteName']/logFile/customFields"

foreach ($name in @('traceparent','tracestate')) {
    $itemFilter = "$filter/add[@logFieldName='$name']"
    $existing = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $itemFilter -Name '.' -ErrorAction SilentlyContinue
    if ($existing -and $PSCmdlet.ShouldProcess($SiteName, "Remove IIS custom log field $name")) {
        Remove-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $filter -Name '.' -AtElement @{ logFieldName = $name }
    }
}
