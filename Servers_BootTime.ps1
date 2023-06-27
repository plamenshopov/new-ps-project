@#$$servers = Get-ADDomainController -filter * | Select-Object -ExpandProperty name | Sort-Object

foreach ($server in $servers){
    try {
        $time = ((get-WMIObject -ComputerName $server -Namespace root\CIMv2 -Class win32_operatingsystem -ErrorAction SilentlyContinue | Select-Object -ExpandProperty lastbootuptime) -split "\.")[0]
    }
    catch {
        Write-Output "$server  Error in connecting" `n | Out-File C:\Users\plamen\Desktop\BootTime.txt -Append
        continue
    }


$year = $time.Substring(0,4) #Вземи от 1ви до 4ти - реално 0 е 1
$month = $time.Substring(4,2) #Вземи от 5 до 7 и т.н.
$day = $time.Substring(6,2)
$hours = $time.Substring(8,2)
$minutes = $time.Substring(10,2)
$seconds = $time.Substring(12,2)

$output = "$month-$day-$year $hours`:$minutes`:$seconds"
$bootdate = [datetime]$output

Write-Output "$server - $bootdate" | Out-File C:\Users\plamen\Desktop\rebootstatus.txt -Append
}