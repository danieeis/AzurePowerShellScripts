Param(
      [Parameter(Mandatory=$True)]
      [string[]]$SavePath,
      [string]$UserName
 )
$VerbosePreference = "Continue"
$TestPath = Test-Path -Path $SavePath -ErrorAction SilentlyContinue
if($TestPath -eq $true){
   Write-Host "The Directory way found. - We're good to go." -ForegroundColor Green
   $AllVM = Get-AzVM -ResourceGroupName "bb-vms-rg" -Status
   foreach($vm in $AllVM){
      $Name = $vm.Name
      try{
         if ($vm.PowerState -eq "VM running"){
            Write-Verbose "Remote Desktop File creating... Virtual Machine name is $Name"
            Get-AzRemoteDesktopFile -ResourceGroupName "bb-vms-rg" -Name $Name -LocalPath "$SavePath\$Name.rdp" -ErrorAction Stop -ErrorVariable Error 
            Write-Verbose "Client VM RDP file ($Name.rdp) downloaded to $SavePath"
            Add-Content $SavePath\$name.rdp -Value username:s:$Username}
         }
      catch{
             Write-Host "Remote Desktop File could not be created"}
      }
    Write-Host " "
    Write-Host "All remote desktop files created. Saved path:>>$SavePath" -ForegroundColor Green
 }
else {
        Write-Host " "
        Write-Host "The Directory path not found" -ForegroundColor Red -BackgroundColor White
        Write-Host " "}