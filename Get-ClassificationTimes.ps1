Class DriverTimes {
    [string]$driver
    [string]$best
    DriverTimes([String]$a,[String]$b){$this.driver = $a; $this.best = $b}
}
$driverList = @()
foreach($driver in ((Curl -Uri "https://hotlap-api.herokuapp.com/classification/3").Content | ConvertFrom-Json)){$driverList += [DriverTimes]::new($driver.name, ([DateTime]::MinValue).AddMilliseconds($driver.best).ToString("mm:ss.fff"))}
$driverList | Sort-Object best | Format-Table
Write-Host $driverList.Count "drivers`r`nCut off approx" (($driverList | Sort-Object best)[[Math]::Floor(0.83 * $driverList.Count)]).best -ForegroundColor Cyan
Read-Host
