
#create path on nfs
#mkdir -p /ocp-pv/apim/system
#mkdir -p /ocp-pv/apim/system-mysql
#mkdir -p /ocp-pv/apim/backend-redis
#mkdir -p /ocp-pv/apim/system-redis
#chmod -R 775 /ocp-pv/apim


echo "Create persistentVolume for 3scale ..."

cat <<EOF | oc create -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: apim-system-pv
spec:
  accessModes:
  - ReadWriteOnce
  - ReadWriteMany
  capacity:
    storage: 50Gi
  claimRef:
    name: system-storage
    namespace: apim
  nfs:
    path: /apim/system
    server: 1a2a3480b1-ytt33.cn-beijing.nas.aliyuncs.com
  persistentVolumeReclaimPolicy: Retain
EOF


cat <<EOF | oc create -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: apim-system-mysql-pv
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 50Gi
  claimRef:
    name: mysql-storage
    namespace: apim
  nfs:
    path: /apim/system-mysql
    server: 1a2a3480b1-ytt33.cn-beijing.nas.aliyuncs.com
  persistentVolumeReclaimPolicy: Retain
EOF


cat <<EOF | oc create -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: apim-backend-redis-pv
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 50Gi
  claimRef:
    name: backend-redis-storage
    namespace: apim
  nfs:
    path: /apim/backend-redis
    server: 1a2a3480b1-ytt33.cn-beijing.nas.aliyuncs.com
  persistentVolumeReclaimPolicy: Retain
EOF


cat <<EOF | oc create -f -
apiVersion: v1
kind: PersistentVolume
metadata:
   name: apim-system-redis-pv
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 50Gi
  claimRef:
    name: system-redis-storage
    namespace: apim
  nfs:
    path: /apim/system-redis
    server: 1a2a3480b1-ytt33.cn-beijing.nas.aliyuncs.com
  persistentVolumeReclaimPolicy: Retain
EOF

