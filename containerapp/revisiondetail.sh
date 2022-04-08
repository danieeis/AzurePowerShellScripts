source vars.sh

az containerapp revision show \
  --name $1 \
  --app $CONTAINERAPP_NAME \
  --resource-group $RESOURCE_GROUP