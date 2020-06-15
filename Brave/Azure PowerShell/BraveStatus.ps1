# Ejecutar para ver el status

$RESOURCE_GROUP = "bb-vms-rg"
Get-AzResource -ResourceGroupName bb-vms-rg | format-table
$AllVMs = Get-AzVM -ResourceGroupName $RESOURCE_GROUP -Status
foreach($vm in $AllVMs)
{
    Write-Host $vm.Name "|" $vm.PowerState
}

