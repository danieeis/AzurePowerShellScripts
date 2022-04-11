source vars.sh

az containerapp show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTAINERAPP_NAME \
  --query properties.configuration.ingress.fqdn
