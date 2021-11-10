Import-Module ActiveDirectory

# Boilerplate
$path="CN=Users"
$wsUsername="Ws-user"
$userCounter=1..20
$ipCounter=1..4
$voipCounter=1..5
$ipCounterG=1..4
$voipCounterG=1..5

Write-Host "!!! Iga kasutaja parool on Admin123"
$dc= Read-Host "Sisestage oma foresti nimi ilma .local'ita (nt. KUUSK): "
$password = "Admin123" | ConvertTo-SecureString -AsPlainText -Force

# Groups
New-AdGroup –name "Super" –groupscope Global
New-AdGroup –name "Managers" –groupscope Global
New-AdGroup –name "IT" –groupscope Global
New-AdGroup –name "IP-Cam" –groupscope Global
New-AdGroup –name "VOIP" –groupscope Global

# Ws-user
foreach ($i in $userCounter)
{
    New-AdUser -Name "$wsUsername$i" -SamAccountName "$wsUsername$i" -Path "$path,DC=$dc,DC=.local" -AccountPassword $password -Enabled $True -ChangePasswordAtLogon $False
}

# IP-Cam user
foreach ($i in $ipCounter)
{
    New-AdUser -Name "IP-Cam$i" -SamAccountName "IP-Cam$i" -Path "$path,DC=$dc,DC=.local" -AccountPassword $password -Enabled $True -ChangePasswordAtLogon $False 
}

# VOIP user
foreach ($i in $voipCounter)
{
    New-AdUser -Name "VOIP-$i" -SamAccountName "VOIP-$i" -Path "$path,DC=$dc,DC=.local" -AccountPassword $password -Enabled $True -ChangePasswordAtLogon $False
}

# Group Membership
Add-ADGroupMember -Identity "Domain Admins" -Members "Ws-user1"
Add-ADGroupMember -Identity "Domain Admins" -Members "Ws-user5"
Add-ADGroupMember -Identity "Domain Admins" -Members "Ws-user10"
Add-ADGroupMember -Identity "Domain Admins" -Members "Ws-user15"
Add-ADGroupMember -Identity "Domain Admins" -Members "Ws-user20"
Add-ADGroupMember -Identity "Super" -Members "Ws-user1"
Add-ADGroupMember -Identity "Super" -Members "Ws-user10"
Add-ADGroupMember -Identity "Super" -Members "Ws-user20"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user1"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user3"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user5"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user7"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user9"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user11"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user13"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user15"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user17"
Add-ADGroupMember -Identity "Managers" -Members "Ws-user19"
Add-ADGroupMember -Identity "IT" -Members "Ws-user5"
Add-ADGroupMember -Identity "IT" -Members "Ws-user6"
Add-ADGroupMember -Identity "IT" -Members "Ws-user15"
Add-ADGroupMember -Identity "IT" -Members "Ws-user19"

foreach ($i in $ipCounterG)
{
    Add-ADGroupMember -Identity "IP-Cam" -Members "IP-Cam$i"
}

foreach ($i in $voipCounterG)
{
    Add-ADGroupMember -Identity "VOIP" -Members "VOIP-$i"
}
