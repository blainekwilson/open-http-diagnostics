<#
.SYNOPSIS
Enables Open HTTP Diagnostics Level 1 custom W3C logging fields for IIS.

.DESCRIPTION
Adds IIS W3C custom logging fields for W3C Trace Context and optional OHD response diagnostics.

Requires IIS 8.5+ and administrator privileges.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SiteName,
    [switch]$ServerLevel
)

Import-Module WebAdministration -ErrorAction Stop

$fields = @(
    @{ LogFieldName = 'traceparent';   SourceName = 'traceparent';   SourceType = 'RequestHeader'  },
    @{ LogFieldName = 'tracestate';    SourceName = 'tracestate';    SourceType = 'RequestHeader'  },
    @{ LogFieldName = 'ohd-trace-id';  SourceName = 'OHD-Trace-ID';  SourceType = 'ResponseHeader' },
    @{ LogFieldName = 'ohd-trace-path';SourceName = 'OHD-Trace-Path';SourceType = 'ResponseHeader' }
)

function Get-LogPath {
    param([string]$SiteName, [switch]$ServerLevel)

    if ($ServerLevel) {
        return 'MACHINE/WEBROOT/APPHOST'
    }

    if (-not $SiteName) {
        throw 'Specify -SiteName or use -ServerLevel.'
    }

    return "IIS:\Sites\$SiteName"
}

$targetPath = Get-LogPath -SiteName $SiteName -ServerLevel:$ServerLevel

foreach ($field in $fields) {
    $existing = Get-WebConfigurationProperty `
        -PSPath $targetPath `
        -Filter 'system.applicationHost/sites/siteDefaults/logFile/customFields' `
        -Name '.' `
        -ErrorAction SilentlyContinue |
        Where-Object { $_.logFieldName -eq $field.LogFieldName }

    if ($existing) {
        Write-Verbose "Custom logging field already exists: $($field.LogFieldName)"
        continue
    }

    if ($PSCmdlet.ShouldProcess($targetPath, "Add custom logging field $($field.LogFieldName)")) {
        Add-WebConfigurationProperty `
            -PSPath $targetPath `
            -Filter 'system.applicationHost/sites/siteDefaults/logFile/customFields' `
            -Name '.' `
            -Value $field

        Write-Host "Added custom logging field: $($field.LogFieldName)"
    }
}

Write-Host 'Open HTTP Diagnostics IIS Level 1 logging configuration complete.'
