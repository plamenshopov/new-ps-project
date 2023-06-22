#$OS = Get-CimInstance -classname Win32_OperatingSystem -ComputerName DEATHMATCH
$RAM = ($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)*1KB

$RemotePC = @{
    classname = "Win32_process"
    ComputerName = "Deathmatch"
    filter = "WorkingSetSize >=$(25MB)"
}

Get-CimInstance @RemotePC | Select-Object -Property ProcessID,Name,
@{Name="WorkingMB";Expression={[math]::Round($_.WorkingSetSize/1mb,2)}},
@{Name="PCTMemory";Expression={"{0:p2}" -f ($_.WorkingSetSize/$RAM)}}

#"files.defaultLanguage": "powershell",
#"powershell.startAutomatically": true,