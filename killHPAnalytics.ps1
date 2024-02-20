$serviceNames = @(
    "HPAppHelperCap",
    "HPDiagsCap",
    "HpTouchpointAnalyticsService",
    "HPNetworkCap",
    "HPOmenCap",
    "HPSysInfoCap"
)

foreach ($serviceName in $serviceNames) {
    # Stop and disable each service
    $stoppedService = Stop-Service -Name $serviceName -PassThru
    if ($stoppedService.Status -eq 'Stopped') {
        Write-Host "SUCCESS - Service '$serviceName' stopped (or is already stopped)."

        # Set service to Disabled
        Set-Service -Name $serviceName -StartupType Disabled

        # Check if the StartupType was successfully set to Disabled
        $updatedService = Get-Service -Name $serviceName
        if ($updatedService.StartType -eq 'Disabled') {
            Write-Host "SUCCESS - Service '$serviceName' is set to disabled (or is already disabled)."
        } else {
            Write-Host "FAIL - Failed to set service '$serviceName' to Disabled."
        }
    } else {
        Write-Host "FAIL - Failed to stop service '$serviceName'."
    }
}