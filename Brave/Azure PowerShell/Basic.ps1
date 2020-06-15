Import-Module -Name Az
Connect-AzAccount
Select-AzSubscription -Subscription "Visual Studio Enterprise"
Get-AzResourceGroup
Get-AzResourceGroup | Format-Table
New-AzResourceGroup -Name "<name>" -Location "<location>"
Get-AzResource | Format-Table
Get-AzResource -ResourceGroupName bb-vms-rg


New-AzVM -Name MyVm -ResourceGroupName ExerciseResources -Credential (Get-Credential) ...

$vm = Get-AzVM  -Name MyVM -ResourceGroupName ExerciseResources
$ResourceGroupName = "ExerciseResources"
$vm = Get-AzVM  -Name MyVM -ResourceGroupName $ResourceGroupName
$vm.HardwareProfile.vmSize = "Standard_DS3_v2"

Update-AzVM -ResourceGroupName $ResourceGroupName  -VM $vm

New-AzVm -ResourceGroupName learn-d27ce574-d028-4dc1-90d2-1041efedfe1a -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22
$vm = Get-AzVM -Name "testvm-eus-01" -ResourceGroupName learn-d27ce574-d028-4dc1-90d2-1041efedfe1a
$vm
$vm.HardwareProfile
$vm.StorageProfile.OsDisk
$vm | Get-AzPublicIpAddress
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table
$vm | Remove-AzNetworkInterface –Force
Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force

Get-AzVMUsage -Location "South Central US"

Get-AzComputeResourceSku | Where-Object {$_.Locations -icontains "centralus"}