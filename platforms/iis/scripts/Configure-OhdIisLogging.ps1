#requires -Version 5.1
#requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter()]
    [switch]$EnableRecommendedW3CFields
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop

function Add-OhdCustomField {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory)] [string]$SiteName,
        [Parameter(Mandatory)] [string]$CustomFieldsFilter,
        [Parameter(Mandatory)] [string]$LogFieldName,
        [Parameter(Mandatory)] [string]$SourceName
    )

    $fields = @(Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$CustomFieldsFilter/add" -Name '.' -ErrorAction SilentlyContinue)
    $existing = $fields | Where-Object { [string]$_.logFieldName -ieq $LogFieldName }
    if ($existing) {
        if ([string]$existing.sourceName -ine $SourceName -or [string]$existing.sourceType -ine 'RequestHeader') {
            throw "Site '$SiteName' has a conflicting custom field named '$LogFieldName'."
        }
        return
    }

    if ($PSCmdlet.ShouldProcess($SiteName, "Add OHD field '$LogFieldName' from request header '$SourceName'")) {
        Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $CustomFieldsFilter -Name '.' -Value @{
            logFieldName = $LogFieldName
            sourceName   = $SourceName
            sourceType   = 'RequestHeader'
        }
    }
}

$sites = @(Get-Website)
if ($sites.Count -eq 0) {
    Write-Warning 'No IIS websites are configured.'
    return
}

foreach ($site in $sites) {
    $siteFilter = "system.applicationHost/sites/site[@name='$($site.Name)']"
    $logFilter = "$siteFilter/logFile"
    $customFieldsFilter = "$logFilter/customFields"
    $logFormatValue = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $logFilter -Name 'logFormat'
    if ($logFormatValue.PSObject.Properties['Value']) {
        $logFormat = [string]$logFormatValue.Value
    }
    else {
        $logFormat = [string]$logFormatValue
    }

    if ($logFormat -ne 'W3C') {
        throw "Site '$($site.Name)' must use W3C logging before OHD fields can be configured."
    }

    Add-OhdCustomField -SiteName $site.Name -CustomFieldsFilter $customFieldsFilter -LogFieldName 'traceparent' -SourceName 'traceparent'
    Add-OhdCustomField -SiteName $site.Name -CustomFieldsFilter $customFieldsFilter -LogFieldName 'tracestate' -SourceName 'tracestate'
    Add-OhdCustomField -SiteName $site.Name -CustomFieldsFilter $customFieldsFilter -LogFieldName 'ohd_trace_id' -SourceName 'OHD-Trace-ID'

    if ($EnableRecommendedW3CFields -and $PSCmdlet.ShouldProcess($site.Name, 'Enable recommended W3C fields')) {
        Set-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $logFilter -Name 'logExtFileFlags' -Value 'Date,Time,ClientIP,Method,UriStem,UriQuery,HttpStatus,BytesSent,TimeTaken,Host,UserAgent,Referer'
    }

    Write-Host "Configured OHD Level 1 fields for IIS site '$($site.Name)'."
    Write-Host "Logs remain in IIS W3C storage: $($env:SystemDrive)\inetpub\logs\LogFiles\W3SVC\$($site.Id)"
}