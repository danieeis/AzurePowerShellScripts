$locName="southcentralus"
$pubName="MicrosoftWindowsDesktop"
$offerName = "Windows-10"
Get-AzVMImageOffer -Location $locName -PublisherName $pubName | Format-Table
Get-AzVMImageSku -PublisherName "MicrosoftWindowsDesktop" -Offer $offerName -Location westus | Select-Object Skus
