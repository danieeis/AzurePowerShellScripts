$json = (Get-Content "../../config.json" -Raw) | ConvertFrom-Json


$storageAcctName = $json.storage_acount
$storageKey = $json.storage_key

Write-Host "account: "$storageAcctName
Write-Host "key: "$storageKey