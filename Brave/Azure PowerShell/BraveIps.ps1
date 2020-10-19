# Ejecutar para ver las ips
param(
        [string]$RESOURCE_GROUP
    )
$Ips = Get-AzNetworkInterface -ResourceGroupName $RESOURCE_GROUP
$vmDetails = New-Object "System.Collections.Generic.List[psobject]"
foreach ($instance in $Ips){
    $Vm = ($instance.VirtualMachine).Id.Split('/') | Select-Object -Last 1
    $PrivateIp = $instance.IpConfigurations.PrivateIpAddress
    $PublicIp = (Get-AzPublicIpAddress -ResourceGroupName $RESOURCE_GROUP -Name ($instance.IpConfigurations.publicIpAddress.Id.Split('/') | Select-Object -Last 1)).IpAddress
    $obj = New-Object psobject -Property @{
        VmName = $vm
        PrivateIp = $PrivateIp
        PublicIp = $PublicIp
    }
    $vmDetails.Add($obj)
}
Write-Output $vmDetails