# I'm retarded and forgot how ints work whatever
$wsUserFolder=1..20
$wsUserPerms1=1..20
$superPerms=1..20
$managerPerms=1..20
$ipCam=1..3
$VOIP=1..5

Write-Host "!!! Jooksuta see skript Domain Adminina (nt. Ws-user1'na) !!!"
Write-Host "!!! See skript ei tee IT grupi permissioneid !!!"
$dc=Read-Host "Sisesta oma DC nimi ilma .local'ita: "

# WS Folders
foreach ($i in $wsUserFolder)
{
    New-Item -Path "C:\" -Name "Ws-user$i" -ItemType "directory"
}

# CAM-VOIP-IT Folder and subdirectories
New-Item -Path "C:\" -Name "CAM-VOIP-IT" -ItemType "directory"
New-Item -Path "C:\CAM-VOIP-IT\" -Name "IP-Cam" -ItemType "directory"
New-Item -Path "C:\CAM-VOIP-IT\" -Name "VOIP" -ItemType "directory"

################################
# PERMISSIONS (HACKY AS SHIT!!)
################################
# WS Users
foreach ($i in $wsUserPerms1)
{
    $acl = Get-Acl "C:\Ws-user$i"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\Ws-user$i","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl "C:\Ws-user$i"
}

# Super Group
foreach ($i in $superPerms)
{
    $acl = Get-Acl "C:\Ws-user$i"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\Super","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl "C:\Ws-user$i"
}

# Managers Group
foreach ($i in $managerPerms)
{
    $acl = Get-Acl "C:\Ws-user$i"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\Managers","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl "C:\Ws-user$i"
}

# CAM-VOIP-IT Folder
# IT Group
$acl = Get-Acl "C:\CAM-VOIP-IT"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\IT","FullControl","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\CAM-VOIP-IT"

# IP-Cam
$acl = Get-Acl "C:\CAM-VOIP-IT"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\IP-Cam","Read","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\CAM-VOIP-IT"

# VOIP
$acl = Get-Acl "C:\CAM-VOIP-IT"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\VOIP","Read","Allow")
$acl.SetAccessRule($AccessRule)
$acl | Set-Acl "C:\CAM-VOIP-IT"

# IP-Cam Folder
foreach ($i in $ipCam)
{
    $acl = Get-Acl "C:\CAM-VOIP-IT\IP-Cam"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\IP-Cam","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl "C:\CAM-VOIP-IT\IP-Cam"
}

# VOIP Folder
foreach ($i in $VOIP)
{
    $acl = Get-Acl "C:\CAM-VOIP-IT\VOIP"
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("$dc\VOIP","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)
    $acl | Set-Acl "C:\CAM-VOIP-IT\VOIP"
}