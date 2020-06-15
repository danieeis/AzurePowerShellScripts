# Ejecutar luego que se usen
$RESOURCE_GROUP = "bb-vms-rg"
$AllVM = Get-AzVM -ResourceGroupName $RESOURCE_GROUP -Status
foreach($vm in $AllVM){
    if ($vm.PowerState -eq "VM running"){
        Write-Host "Deallocating VM: " $vm.Name
        Stop-AzVM -ResourceGroupName $RESOURCE_GROUP -Name $vm.Name -Force
    }else{
        Write-Host "Already Deallocated VM: " $vm.Name
    }
}
#Stop-AzVM -ResourceGroupName bb-vms-rg -Name bb-westus-vm-4 -Force
Write-Host "Ya se desasignaron las VM"