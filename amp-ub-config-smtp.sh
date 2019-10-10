
AMP_PROJECT_NAME=apim

oc project $AMP_PROJECT_NAME
oc patch configmap smtp -p '{"data":{"address":"smtp.partner.outlook.cn"}}'
oc patch configmap smtp -p '{"data":{"username":"maxadmin@universalbeijing.com"}}'
oc patch configmap smtp -p '{"data":{"password":"Minions@2019"}}'
oc patch configmap smtp -p '{"data":{"authentication":"login"}}'
oc patch configmap smtp -p '{"data":{"openssl.verify.mode":""}}'
oc patch configmap smtp -p '{"data":{"port":"587"}}'
oc patch configmap smtp -p '{"data":{"domain":""}}'

oc set env dc/system-sidekiq NOTIFICATION_EMAIL=maxadmin@universalbeijing.com

oc rollout latest dc/system-app
oc rollout latest dc/system-sidekiq

