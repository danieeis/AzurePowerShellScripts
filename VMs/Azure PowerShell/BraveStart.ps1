# Ejecutar a los 20 dias
param(
        [string]$Prefix,
        [string]$VMS
    )
$RESOURCE_GROUP = "bb-vms-rg"
$VM_NAME = "bb-" + $Prefix + "-vm-"
For ($i = 1; $i -le $VMS; $i++){
    $vmName = $VM_NAME + $i
    Write-Host "Starting VM: " $vmName
    Start-AzVM -ResourceGroupName $RESOURCE_GROUP  -Name $vmName -ErrorAction Stop -ErrorVariable Error
}

#Start-AzVM -ResourceGroupName bb-vms-rg -Name bb-westus-vm-4
Write-Host "Ya se iniciaron las VM en " $Location
