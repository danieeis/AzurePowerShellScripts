source vars.sh

##CREATE RESOURCE GROUP
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

##CREATE ENV 
az containerapp env create \
  --name $CONTAINERAPPS_ENVIRONMENT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION

## CREATE APP
az containerapp create -n $CONTAINERAPP_NAME -g $RESOURCE_GROUP \
    --image danieeis.azurecr.io/calculatorfcla:latest --environment $CONTAINERAPPS_ENVIRONMENT \
    --ingress external --target-port 80 \
    --registry-server $REGISTRY_SERVER --registry-username $REGISTRY_USER --registry-password $REGISTRY_PASSWORD \
    --query properties.configuration.ingress.fqdn \
    --secrets defaultconnection=$DBCON sendgridkey=$SENDGRIDKEY \
    --env-vars ConnectionStrings__DefaultConnection=secretref:defaultconnection SendGridKey=secretref:sendgridkey \
    --cpu 0.5 --memory 1.0Gi \
    --min-replicas 0 --max-replicas 5