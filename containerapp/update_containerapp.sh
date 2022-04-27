source vars.sh

az containerapp update \
  --name $CONTAINERAPP_NAME \
  --resource-group $RESOURCE_GROUP \
  --image $IMAGE \
  --min-replicas 1 --max-replicas 5