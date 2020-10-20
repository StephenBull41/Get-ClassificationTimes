Class DriverTimes {

    [string]$driver
    [string]$best

}

$driverList = @()
foreach($driver in ((Curl -Uri "https://hotlap-api.herokuapp.com/classification/3").Content | ConvertFrom-Json)){

    $d = [DriverTimes]::new()
    $d.driver = $driver.name
    $d.best = ([DateTime]::MinValue).AddMilliseconds($driver.best).ToString("mm:ss.fff")
    $driverList += $d
}
$driverList | Sort-Object best | Format-Table
Read-Host