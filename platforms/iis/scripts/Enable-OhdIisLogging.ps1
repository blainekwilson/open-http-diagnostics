#requires -RunAsAdministrator
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SiteName = 'Default Web Site',

    [Parameter()]
    [switch]$EnableRecommendedW3CFields
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop

$site = Get-Website -Name $SiteName -ErrorAction Stop
$siteFilter = "system.applicationHost/sites/site[@name='$SiteName']"
$customFieldsFilter = "$siteFilter/logFile/customFields"

$logFormat = Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$siteFilter/logFile" -Name 'logFormat'
if ([string]$logFormat.Value -ne 'W3C') {
    throw "Site '$SiteName' must use W3C logging before custom OHD fields can be configured."
}

function Add-OhdCustomField {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] [string]$LogFieldName,
        [Parameter(Mandatory)] [string]$SourceName
    )

    $fields = @(Get-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$customFieldsFilter/add" -Name '.' -ErrorAction SilentlyContinue)
    $existing = $fields | Where-Object { [string]$_.logFieldName -ieq $LogFieldName }

    if ($existing) {
        if ([string]$existing.sourceName -ine $SourceName -or [string]$existing.sourceType -ine 'RequestHeader') {
            throw "Custom log field '$LogFieldName' already exists with a different source. Remove or rename it before continuing."
        }
        Write-Verbose "Custom log field '$LogFieldName' is already correctly configured."
        return
    }

    if ($PSCmdlet.ShouldProcess($SiteName, "Add IIS custom request-header log field '$LogFieldName' from '$SourceName'")) {
        Add-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter $customFieldsFilter -Name '.' -Value @{
            logFieldName = $LogFieldName
            sourceName   = $SourceName
            sourceType   = 'RequestHeader'
        }
    }
}

Add-OhdCustomField -LogFieldName 'traceparent' -SourceName 'traceparent'
Add-OhdCustomField -LogFieldName 'tracestate' -SourceName 'tracestate'
Add-OhdCustomField -LogFieldName 'ohd_trace_id' -SourceName 'OHD-Trace-ID'

if ($EnableRecommendedW3CFields) {
    # Standard W3C fields are represented as flags in logExtFileFlags.
    $recommendedFlags = 'Date,Time,ClientIP,Method,UriStem,UriQuery,HttpStatus,BytesSent,TimeTaken,ServerName,UserAgent,Referer'
    if ($PSCmdlet.ShouldProcess($SiteName, "Set recommended W3C fields: $recommendedFlags")) {
        Set-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter "$siteFilter/logFile" -Name 'logExtFileFlags' -Value $recommendedFlags
    }
}

Write-Host "Configured OHD Level 1 custom fields for IIS site '$SiteName'."
Write-Host 'Fields: traceparent, tracestate, ohd_trace_id (source OHD-Trace-ID)'
