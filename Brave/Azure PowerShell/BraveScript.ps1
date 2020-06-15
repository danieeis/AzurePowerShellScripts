# .\setupEnvironment.ps1 -Location "westus"
# Ejecutar cuando se vaya a iniciar un ciclo
#Params
param(
        [string]$Location,
        [string]$Prefix,
        [string]$VM_SIZE,
        [string]$SubnetPrefix,
        [string]$VnetPrefix,
        [string]$VMS,
        [Switch]$CreateRG
    )

# Variables
$VMS = $VMS
$RESOURCE_GROUP = "bb-vms-rg"
$VM_NAME = "bb-" + $Prefix + "-vm-"
$VNET = "bb-vnet-" + $Prefix
$SubnetName = "default-" + $Prefix
$USERNAME = "brave"
$PASS = ConvertTo-SecureString "bravemachine12." -AsPlainText -Force
if ($CreateRG){
    Write-Host "Creating group: "$RESOURCE_GROUP
    New-AzResourceGroup -Name $RESOURCE_GROUP -Location $Location
}
New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetPrefix -ErrorAction Stop -ErrorVariable Error
New-AzVirtualNetwork -Name $VNET -ResourceGroupName $RESOURCE_GROUP -Location $Location -AddressPrefix $VnetPrefix -Subnet $SingleSubnet -ErrorAction Stop -ErrorVariable Error
$fileUri = @("https://cs710032000c7a3ac04.blob.core.windows.net/scripts/InstallBrave.ps1")
$settings = @{"fileUris" = $fileUri};

$storageAcctName = "XXXX"
$storageKey = "XXXX"
$protectedSettings = @{"storageAccountName" = $storageAcctName; "storageAccountKey" = $storageKey; "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File InstallBrave.ps1"};


$Credentials = New-Object System.Management.Automation.PSCredential $USERNAME,$PASS
For ($i = 1; $i -le $VMS; $i++)
{
    $RANDOM =  Get-Random -Minimum 0 -Maximum 1000
    $vmName = $VM_NAME + $i
    $IPNAME = $vmName+$RANDOM
    Write-Host "Creating VM: "$vmName
    New-AzVm `
    -ResourceGroupName $RESOURCE_GROUP `
    -Location $Location `
    -Name $vmName `
    -VirtualNetworkName $VNET `
    -SubnetName $SubnetName `
    -Image "MicrosoftWindowsDesktop:Windows-10:rs4-pro:latest" `
    -Credential $Credentials `
    -OpenPorts 80,3389 `
    -PublicIpAddressName $IPNAME `
    -Size $VM_SIZE -ErrorAction Stop -ErrorVariable Error

    Set-AzVMExtension -ResourceGroupName $RESOURCE_GROUP `
    -Location $Location `
    -VMName $vmName `
    -Name "InstallBrave" `
    -Publisher "Microsoft.Compute" `
    -ExtensionType "CustomScriptExtension" `
    -TypeHandlerVersion "1.10" `
    -Settings $settings `
    -ProtectedSettings $protectedSettings
}

$AllVM = Get-AzVM -ResourceGroupName $RESOURCE_GROUP -Status
foreach($vm in $AllVM){
    if ($vm.PowerState -eq "VM running"){
        Write-Host "Deallocating VM: " $vm.Name
        Stop-AzVM -ResourceGroupName $RESOURCE_GROUP -Name $vm.Name -Force
    }else{
        Write-Host "Already Deallocated VM: " $vm.Name
    }
}

Write-Host "Ya se desasignaron las VM"