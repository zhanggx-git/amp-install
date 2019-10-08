
AMP_PROJECT_NAME=apim
AMP_WILDCARD_DOMAIN=dp.paas-test.eubrmb.com
AMP_TENANT_NAME=api-sandbox
AMP_MASTER_NAME=api-master

#oc new-project $AMP_PROJECT_NAME --display-name=$AMP_PROJECT_NAME"-3scale" --description="3scale api management"
oc new-project $AMP_PROJECT_NAME --display-name=$AMP_PROJECT_NAME --description="3scale api management"

oc patch namespace $AMP_PROJECT_NAME -p '{"metadata":{"annotations":{"openshift.io/node-selector":"apigw=false"}}}'

oc new-app --file ./amp-ub-2.6.yml \
           --param WILDCARD_DOMAIN=$AMP_WILDCARD_DOMAIN \
           --param TENANT_NAME=$AMP_TENANT_NAME \
           --param MASTER_NAME=$AMP_MASTER_NAME \
            > install_amp_${AMP_PROJECT_NAME}.log

tail -f install_amp_${AMP_PROJECT_NAME}.log


