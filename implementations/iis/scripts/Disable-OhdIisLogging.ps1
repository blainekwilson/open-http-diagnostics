<#
.SYNOPSIS
Removes Open HTTP Diagnostics IIS custom logging fields.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SiteName,
    [switch]$ServerLevel
)

Import-Module WebAdministration -ErrorAction Stop

$fields = @('traceparent', 'tracestate', 'ohd-trace-id', 'ohd-trace-path')

if ($ServerLevel) {
    $targetPath = 'MACHINE/WEBROOT/APPHOST'
} elseif ($SiteName) {
    $targetPath = "IIS:\Sites\$SiteName"
} else {
    throw 'Specify -SiteName or use -ServerLevel.'
}

foreach ($field in $fields) {
    if ($PSCmdlet.ShouldProcess($targetPath, "Remove custom logging field $field")) {
        Remove-WebConfigurationProperty `
            -PSPath $targetPath `
            -Filter 'system.applicationHost/sites/siteDefaults/logFile/customFields' `
            -Name '.' `
            -AtElement @{ logFieldName = $field } `
            -ErrorAction SilentlyContinue

        Write-Host "Removed custom logging field if present: $field"
    }
}
