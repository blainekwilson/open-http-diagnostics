#requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter()]
    [switch]$FailOnNonConformance
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module WebAdministration -ErrorAction Stop

$traceId = '4bf92f3577b34da6a3ce929d0e0e4736'
$traceParent = "00-$traceId-00f067aa0ba902b7-01"

function Get-HttpBinding {
    param([Parameter(Mandatory)]$Site)

    $binding = Get-WebBinding -Name $Site.Name -Protocol 'http' | Select-Object -First 1
    if (-not $binding) {
        return $null
    }

    $parts = $binding.bindingInformation.Split(':')
    $port = [int]$parts[1]
    $hostName = $parts[2]
    if ([string]::IsNullOrWhiteSpace($hostName)) {
        $hostName = '127.0.0.1'
    }

    return [pscustomobject]@{
        Uri      = "http://127.0.0.1:$port/"
        HostName = $hostName
    }
}

function Get-LatestW3CRecord {
    param([Parameter(Mandatory)]$Site)

    $logDirectory = Join-Path $env:SystemDrive "inetpub\logs\LogFiles\W3SVC$($Site.Id)"
    $logFile = Get-ChildItem -Path $logDirectory -Filter '*.log' -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $logFile) {
        return $null
    }

    $lines = Get-Content -Path $logFile.FullName
    $fieldLine = $lines | Where-Object { $_ -like '#Fields:*' } | Select-Object -Last 1
    $dataLine = $lines | Where-Object { $_ -and $_ -notlike '#*' } | Select-Object -Last 1
    if (-not $fieldLine -or -not $dataLine) {
        return $null
    }

        $fields = ($fieldLine -replace '^#Fields:\s*', '') -split '\s+'
    $values = $dataLine -split '\s+'
    $record = @{}
    for ($index = 0; $index -lt [Math]::Min($fields.Count, $values.Count); $index++) {
        $record[$fields[$index]] = $values[$index]
    }

    return [pscustomobject]@{
        Path   = $logFile.FullName
        Fields = $fields
        Values = $record
    }
}

$results = foreach ($site in @(Get-Website)) {
    $binding = Get-HttpBinding -Site $site
    if (-not $binding) {
        [pscustomobject]@{ SiteName = $site.Name; Status = 'Skipped'; Detail = 'No HTTP binding' }
        continue
    }

    $headers = @{
        Host          = $binding.HostName
        traceparent   = $traceParent
        tracestate    = 'ohd=test'
        'OHD-Trace-ID' = $traceId
    }
    try {
        Invoke-WebRequest -Uri $binding.Uri -Headers $headers -UseBasicParsing -TimeoutSec 15 | Out-Null
        $record = $null
        for ($attempt = 0; $attempt -lt 10 -and $null -eq $record; $attempt++) {
            Start-Sleep -Seconds 1
            $record = Get-LatestW3CRecord -Site $site
        }
        $conforms = $null -ne $record -and
            $record.Values.ContainsKey('traceparent') -and $record.Values['traceparent'] -eq $traceParent -and
            $record.Values.ContainsKey('tracestate') -and $record.Values['tracestate'] -eq 'ohd=test' -and
            $record.Values.ContainsKey('ohd_trace_id') -and $record.Values['ohd_trace_id'] -eq $traceId
        [pscustomobject]@{
            SiteName = $site.Name
            Status   = if ($conforms) { 'PASS' } else { 'FAIL' }
            Detail   = if ($record) { $record.Path } else { 'No W3C record found' }
        }
    }
    catch {
        [pscustomobject]@{ SiteName = $site.Name; Status = 'FAIL'; Detail = $_.Exception.Message }
    }
}

$results | Format-Table -AutoSize
if ($FailOnNonConformance -and @($results | Where-Object Status -eq 'FAIL').Count -gt 0) {
    throw 'One or more IIS websites failed OHD Level 1 verification.'
}