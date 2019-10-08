
AMP_PROJECT_NAME=apim

oc project $AMP_PROJECT_NAME
oc patch configmap smtp -p '{"data":{"address":""}}'
#oc patch configmap smtp -p '{"data":{"username":""}}'
#oc patch configmap smtp -p '{"data":{"password":""}}'
oc patch configmap smtp -p '{"data":{"port":""}}'

oc rollout latest dc/system-app
oc rollout latest dc/system-sidekiq

