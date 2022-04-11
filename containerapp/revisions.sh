source vars.sh

az containerapp revision list \
  --name $CONTAINERAPP_NAME \
  --resource-group $RESOURCE_GROUP \
  -o table