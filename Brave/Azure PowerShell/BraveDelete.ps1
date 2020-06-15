# Ejecutar a los 31 dias
$RESOURCE_GROUP = "bb-vms-rg"
Write-Host "Eliminando grupo: "$RESOURCE_GROUP
Remove-AzResourceGroup -Name $RESOURCE_GROUP -Force
Get-AzResourceGroup | Format-Table