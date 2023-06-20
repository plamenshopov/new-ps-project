Enter-PSSession BDC
$ServerWAC = "MEDIA"
$Servers = "DC","EXCHANGE","HOST3","HOST4"
foreach($Server in $Servers)
{
     Set-ADComputer -Identity (Get-ADComputer $Server) -PrincipalsAllowedToDelegateToAccount (Get-ADComputer $ServerWAC)
}