# .\setupEnvironment.ps1 -Location "westus"
# Ejecutar cuando se vaya a iniciar un ciclo
#Params
param(
        [string]$Location,
        [Switch]$CreateRG
    )

# Variables
$VMS = 5
$RESOURCE_GROUP = "bb-vms-rg"
$VM_NAME = "bb-" + $Location + "-vm-"
$VNET = "bb-vnet" + $Location
$VM_SIZE = "Standard_A1_v2"
$USERNAME = "brave"
$PASS = ConvertTo-SecureString "bravemachine12." -AsPlainText -Force
if ($Location -like "westus"){
    $VM_SIZE = "Standard_D1"
    Write-Host "Changed vm size : "$VM_SIZE
}
if ($CreateRG){
    Write-Host "Creating group: "$RESOURCE_GROUP
    New-AzResourceGroup -Name $RESOURCE_GROUP -Location $Location
}

$Subnet= New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
New-AzVirtualNetwork -Name $VNET -ResourceGroupName $RESOURCE_GROUP -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

$Credentials = New-Object System.Management.Automation.PSCredential $USERNAME,$PASS
For ($i = 1; $i -lt $VMS; $i++)
{
    $RANDOM =  Get-Random -Minimum 0 -Maximum 1000
    $vmName = $VM_NAME + $i
    $IPNAME = $vmName+$RANDOM
    Write-Host "Creating VM: "$vmName
    New-AzVm `
    -ResourceGroupName $RESOURCE_GROUP `
    -Name $vmName `
    -VirtualNetworkName $VNET `
    -SubnetName "default" `
    -Image "MicrosoftWindowsDesktop:Windows-10:20h1-pro:latest" `
    -Credential $Credentials `
    -OpenPorts 80,3389 `
    -PublicIpAddressName $IPNAME `
    -Size $VM_SIZE
}

Get-AzVM -ResourceGroupName $RESOURCE_GROUP 
