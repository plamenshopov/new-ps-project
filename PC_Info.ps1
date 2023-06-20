$Computers = Get-Content C:\VSCode\Computers.txt | Where-Object {($_.Length -gt 0) -and (Test-WSMan $_.trim())}

Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $Computers.trim() | Select-Object `
-property @{Name="Computer Name";Expression={$_.CSname}},
 @{Name="OS";Expression={$_.Caption.replace("Microsoft","").Trim()}},
 @{Name="Uptime";Expression={New-Timespan -Start $_.LastBootUpTume -end (Get-Date)}},
 @{Name="Installed";Expression={"{0:MMMyyyy}" -f $_.InstallDate}},
 @{Name="InstallAge";Expression={(Get-Date) - $_.InstallAge}},
 @{Name="TotalMemory";Expression={$_.TotalVisibleMemorySize/1MB -as [int]}}| Out-ConsoleGridView
