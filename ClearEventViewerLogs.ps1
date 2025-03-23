<#
.SYNOPSIS
    Cleanup of all Event Viewer logs, including classic logs and modern logs (channels).

.DESCRIPTION
    This script lists all available logs on the system and clears each one.
    It can be executed in PowerShell with administrative privileges.

    Compatible with:
    - Windows Server 2012 / 2016 / 2019 / 2022
    - Windows 10 / 11 (if needed on clients)

.AUTHOR
	Initial Script/Thoughts.......: Hebert Seven
	Blog..........................: Blog: http://hebertseven.com

#>

# Checks for administrative privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator!"
    Exit
}

Write-Host "Starting cleanup of ALL Event Viewer logs..." -ForegroundColor Cyan

# Retrieves the list of all logs
$logNames = wevtutil el

foreach ($log in $logNames) {
    try {
        Write-Host "Clearing log: $log" -ForegroundColor Yellow
        wevtutil cl "$log"
    } catch {
        Write-Warning "Failed to clear the log '$log': $_"
    }
}

Write-Host "All logs have been successfully processed." -ForegroundColor Green
