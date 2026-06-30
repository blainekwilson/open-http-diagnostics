<#
.SYNOPSIS
Tests whether Open HTTP Diagnostics IIS custom logging fields are configured.
#>

[CmdletBinding()]
param(
    [string]$SiteName,
    [switch]$ServerLevel
)

Import-Module WebAdministration -ErrorAction Stop

$expected = @('traceparent', 'tracestate', 'ohd-trace-id', 'ohd-trace-path')

if ($ServerLevel) {
    $targetPath = 'MACHINE/WEBROOT/APPHOST'
} elseif ($SiteName) {
    $targetPath = "IIS:\Sites\$SiteName"
} else {
    throw 'Specify -SiteName or use -ServerLevel.'
}

$configured = Get-WebConfigurationProperty `
    -PSPath $targetPath `
    -Filter 'system.applicationHost/sites/siteDefaults/logFile/customFields' `
    -Name '.' `
    -ErrorAction SilentlyContinue

foreach ($field in $expected) {
    $found = $configured | Where-Object { $_.logFieldName -eq $field }
    [PSCustomObject]@{
        Field = $field
        Configured = [bool]$found
    }
}
