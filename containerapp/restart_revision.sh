source vars.sh

az containerapp revision restart \
  --revision $1 \
  --name $CONTAINERAPP_NAME \
  --resource-group $RESOURCE_GROUP