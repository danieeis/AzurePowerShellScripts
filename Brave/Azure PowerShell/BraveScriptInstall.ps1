$RESOURCE_GROUP = "bb-vms-rg"
$fileUri = "https://github.com/danieeis/AzureScripts/blob/master/Brave/Azure%20PowerShell/InstallBrave.ps1"
$AllVM = Get-AzVM -ResourceGroupName "bb-vms-rg" -Status
foreach($vm in $AllVM){
    if ($vm.PowerState -eq "VM running"){
        Set-AzVMCustomScriptExtension -ResourceGroupName $RESOURCE_GROUP `
        -VMName $vm.Name `
        -FileUri $fileUri `
        -Run 'InstallBrave.ps1' `
        -Name "InstallBrave"
    }
}

Set-AzVMCustomScriptExtension -ResourceGroupName "bb-vms-rg" `
        -VMName "bb-westus-vm-4" `
        -Location "westus" `
        -FileUri "https://github.com/danieeis/AzureScripts/blob/master/Brave/Azure%20PowerShell/InstallBrave.ps1" `
        -Run 'InstallBrave.ps1' `
        -Name "InstallBrave"