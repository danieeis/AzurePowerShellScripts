[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$url='https://referrals.brave.com/latest/BraveBrowserSetup-GAB835.exe' 
Invoke-WebRequest -Uri $url -OutFile 'BraveBrowserSetup-GAB835.exe' -UseBasicParsing
.\BraveBrowserSetup-GAB835.exe

Set-AzVMExtension -ResourceGroupName $RESOURCE_GROUP `
    -Location $Location `
    -VMName $vmName `
    -Name "InstallBrave" `
    -Publisher "Microsoft.Compute" `
    -ExtensionType "CustomScriptExtension" `
    -TypeHandlerVersion "1.10" `
    -Settings $settings `
    -ProtectedSettings $protectedSettings