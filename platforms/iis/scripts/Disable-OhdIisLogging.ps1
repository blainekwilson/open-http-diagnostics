#requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SiteName = 'Default Web Site'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop
Get-Website -Name $SiteName -ErrorAction Stop | Out-Null

$filter = "system.applicationHost/sites/site[@name='$SiteName']/logFile/customFields"
foreach ($name in @('traceparent', 'tracestate', 'ohd_trace_id')) {
    $fields = @(Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$filter/add" -Name '.' -ErrorAction SilentlyContinue)
    $existing = $fields | Where-Object { [string]$_.logFieldName -ieq $name }
    if ($existing -and $PSCmdlet.ShouldProcess($SiteName, "Remove IIS custom log field '$name'")) {
        Remove-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $filter -Name '.' -AtElement @{ logFieldName = $name }
    }
}

Write-Host "Removed OHD custom fields from IIS site '$SiteName'. Standard W3C field selection was not changed."
