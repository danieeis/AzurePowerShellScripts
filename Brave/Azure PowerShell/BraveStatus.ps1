# Ejecutar para ver el status
Write-Host "Grupo de recursos: "
Get-AzResourceGroup | Format-Table
$RESOURCE_GROUP = "bb-vms-rg"
$AllVMs = Get-AzVM -ResourceGroupName $RESOURCE_GROUP -Status
foreach($vm in $AllVMs)
{
    Write-Host $vm.Name "|" $vm.PowerState
}
$RESOURCE_GROUP = "bb-vps-rg"
$AllVMs = Get-AzVM -ResourceGroupName $RESOURCE_GROUP -Status
foreach($vm in $AllVMs)
{
    Write-Host $vm.Name "|" $vm.PowerState
}
