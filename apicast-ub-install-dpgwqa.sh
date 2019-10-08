
AMP_PROJECT_NAME=apim
AMP_WILDCARD_DOMAIN=dp.paas-test.eubrmb.com

APICAST_PROJECT_NAME=dpgwqa
APICAST_APP_NAME_PREFIX=dpgw01qa
APICAST_TENANT=dpqa
APICAST_TENANT_ACCESS_TOKEN=be8ef7b6a69fefbe353db3ded81b70f33437306bbafe9f17152325b70101e723
#create APIcast access_token by tenant portal
#"name": "APIcast", "scopes": ["account_management"],"permission": "ro"



##################################################################################
##############################CONSTAND.DO NOT MODIFY##############################
APICAST_STAGING_APP_NAME=$APICAST_APP_NAME_PREFIX-staging
APICAST_PRODUCTION_APP_NAME=$APICAST_APP_NAME_PREFIX-production

APICAST_TENANT_PORTAL_ENDPOINT=$APICAST_TENANT-admin.$AMP_WILDCARD_DOMAIN
#backend-listener.<3SCALE_PROJECT>.svc.cluster.local:3000
APICAST_BACKEND_ENDPOINT=http://backend-listener.$AMP_PROJECT_NAME.svc.cluster.local:3000

########
#oc new-project $APICAST_PROJECT_NAME --display-name=$APICAST_PROJECT_NAME"-apicast" --description="3scale gateway apicast"
oc new-project $APICAST_PROJECT_NAME --display-name=$APICAST_PROJECT_NAME --description="3scale gateway apicast"

oc adm pod-network join-projects --to=$AMP_PROJECT_NAME $APICAST_PROJECT_NAME

oc create secret generic apicast-configuration-url-secret \
           --from-literal=password=https://$APICAST_TENANT_ACCESS_TOKEN@$APICAST_TENANT_PORTAL_ENDPOINT \
           --type=kubernetes.io/basic-auth

#staging
#           --param BACKEND_ENDPOINT_OVERRIDE=$APICAST_BACKEND_ENDPOINT \
oc new-app --file ./apicast-ub-2.6.yml \
           --param APICAST_NAME=$APICAST_STAGING_APP_NAME \
           --param DEPLOYMENT_ENVIRONMENT=staging \
           --param CONFIGURATION_LOADER=lazy \
           --param CONFIGURATION_CACHE=0 \
            > install_apicast_${APICAST_PROJECT_NAME}.log
oc set env dc/$APICAST_STAGING_APP_NAME BACKEND_ENDPOINT_OVERRIDE=$APICAST_BACKEND_ENDPOINT
oc create route edge $APICAST_STAGING_APP_NAME --service $APICAST_STAGING_APP_NAME

#production
#           --param BACKEND_ENDPOINT_OVERRIDE=$APICAST_BACKEND_ENDPOINT \
oc new-app --file ./apicast-ub-2.6.yml \
           --param APICAST_NAME=$APICAST_PRODUCTION_APP_NAME \
           --param DEPLOYMENT_ENVIRONMENT=production \
           --param CONFIGURATION_LOADER=boot \
           --param CONFIGURATION_CACHE=300 \
            >> install_apicast_${APICAST_PROJECT_NAME}.log
oc set env dc/$APICAST_PRODUCTION_APP_NAME BACKEND_ENDPOINT_OVERRIDE=$APICAST_BACKEND_ENDPOINT
oc create route edge $APICAST_PRODUCTION_APP_NAME --service $APICAST_PRODUCTION_APP_NAME


tail -f install_apicast_${APICAST_PROJECT_NAME}.log

