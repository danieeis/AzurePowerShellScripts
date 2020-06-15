$Location = "westus"
$VNET = "bb-vnet" + $Location
$RESOURCE_GROUP = "bb-vms-rg"

#Write-Host "Creating group: "$RESOURCE_GROUP
#New-AzResourceGroup -Name $RESOURCE_GROUP -Location $Location

$Subnet= New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.0.0.0/24
New-AzVirtualNetwork -Name $VNET -ResourceGroupName $RESOURCE_GROUP -Location $Location -AddressPrefix 10.0.0.0/16 -Subnet $Subnet

$Location = ""
$Subnet= New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.1.0.0/24
New-AzVirtualNetwork -Name $VNET -ResourceGroupName $RESOURCE_GROUP -Location $Location -AddressPrefix 10.1.0.0/16 -Subnet $Subnet

$Location = ""
$Subnet= New-AzVirtualNetworkSubnetConfig -Name default -AddressPrefix 10.1.0.0/24
New-AzVirtualNetwork -Name $VNET -ResourceGroupName $RESOURCE_GROUP -Location $Location -AddressPrefix 10.1.0.0/16 -Subnet $Subnet