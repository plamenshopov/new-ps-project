Import-Module ActiveDirectory
$group = Get-ADGroup -Filter {Name -eq 'TEST USERS'}
$members = Get-ADGroupMember -Identity $group
$result = @()
foreach ($member in $members) {
$obj = New-Object PSObject
$obj | Add-Member -Type NoteProperty -Name "Type of Object" -Value $members.ObjectClass
$obj | Add-Member -Type NoteProperty -Name "Email" -Value (Get-ADUser -Identity $members.SamAccountName).EmailAddress
$obj | Add-Member -Type NoteProperty -Name "SamAccountName" -Value $member.SamAccountName
$obj | Add-Member -Type NoteProperty -Name "Enabled" -Value (Get-ADUser -Identity $member.SamAccountName).Enabled
$result += $obj
}
$result | Export-Csv -Path "C:\Temp\TEST USERS.csv" -NoTypeInformation