# Ejecutar a los 20 dias
param(
        [string[]]$Location
    )
$VMS = 5
$RESOURCE_GROUP = "bb-vms-rg"
$VM_NAME = "bb-" + $Location + "-vm-"
For ($i = 1; $i -lt $VMS; $i++){
    $vmName = $VM_NAME + $i
    Write-Host "Starting VM: " $vmName
    Start-AzVM -ResourceGroupName $RESOURCE_GROUP  -Name $vmName
}

Write-Host "Ya se iniciaron las VM en " $Location
