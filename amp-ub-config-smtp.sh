
AMP_PROJECT_NAME=apim

oc project $AMP_PROJECT_NAME
oc patch configmap smtp -p '{"data":{"address":"universalbeijing-com.mail.protection.partner.outlook.cn"}}'
#oc patch configmap smtp -p '{"data":{"username":""}}'
#oc patch configmap smtp -p '{"data":{"password":""}}'
oc patch configmap smtp -p '{"data":{"port":25}}'

oc rollout latest dc/system-app
oc rollout latest dc/system-sidekiq

