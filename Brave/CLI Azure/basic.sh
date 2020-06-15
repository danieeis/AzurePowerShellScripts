export RESOURCE_GROUP=[sandbox resource group name]
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

export LOCATION=eastus2

az group create -n $RESOURCEGROUP -l $LOCATION
az group list -o table
az vm list -o table

az group list --output table

az group list --query "[?name == '$RESOURCE_GROUP']"
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
az appservice plan list --output table
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
az webapp list --output table
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration

az vm image list --location eastus --output table # Lista las imagenes disponibles por region
az vm image list --publisher Microsoft --output table --all # List las imagenes por publicador
az vm image list --sku Wordpress --output table --all # Lista las imagenes por licencias
az vm image list --output table
az vm list-sizes --location eastus --output table # Lista de de tama;os disponibles en la region

az vm list-ip-addresses -n SampleVM -o table
az vm list -o table -g $RESOURCEGROUP
az vm list-ip-addresses -o table -g $RESOURCEGROUP

az vm list-usage --location "South Central US"
az vm show -d -g $ResourceGroupName -n $VmName --query "publicIps" -o tsv
az account list-locations --query "[].{DisplayName:displayName, Name:name}" -o table

az vm deallocate -n $VmName -g $ResourceGroupName
az vm show -d -g $ResourceGroupName -n $VmName --query "powerState" -o tsv
az group delete --name $ResourceGroupName --yes
az vm open-port --port 80 --resource-group $ResourceGroupName --name $VmName

 mstsc /v:52.255.154.200

az deployment group validate \
  --resource-group $RESOURCEGROUP \
  --template-file azuredeploy.json \
  --parameters adminUsername=braveuser \
  --parameters adminPassword=bravemachine12. \
  --parameters dnsLabelPrefix=brave-$RANDOM

az vm create \
    --resource-group brave-browser-vms-1 \
    --name brave-vm01 \
    --image Win2016Datacenter \
    --admin-username brave1 \
    --admin-password virtualbrave12. \
    --vnet-name brave-browser-vnet1 \
    --size Standard_A2m_v2 \
    --subnet default

RESOURCEGROUP=brave-01-vm-rg
LOCATION=eastus2
az group create --name $RESOURCEGROUP --location $LOCATION
USERNAME=azureuser
PASSWORD=$(openssl rand -base64 32)
DNS_LABEL_PREFIX=brave-$RANDOM
az deployment group validate \
  --resource-group $RESOURCEGROUP \
  --template-uri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json" \
  --parameters adminUsername=$USERNAME \
  --parameters adminPassword=$PASSWORD \
  --parameters dnsLabelPrefix=$DNS_LABEL_PREFIX