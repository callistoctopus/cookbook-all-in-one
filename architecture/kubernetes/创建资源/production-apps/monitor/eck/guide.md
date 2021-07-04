
# Deploy ECK
kubectl apply -f https://download.elastic.co/downloads/eck/1.6.0/all-in-one.yaml

kubectl -n elastic-system logs -f statefulset.apps/elastic-operator

# Deploy an Elasticsearch cluster
cat <<EOF | kubectl apply -f -
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: quickstart
spec:
  version: 7.13.2
  nodeSets:
  - name: default
    count: 1
    config:
      node.store.allow_mmap: false
EOF

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: data-pv0
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 3Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  claimRef:
    namespace: default
    name: elasticsearch-data-quickstart-es-default-0
  hostPath:
    path: "/mnt/data"
EOF

kubectl get elasticsearch

kubectl get service quickstart-es-http

PASSWORD=$(kubectl get secret quickstart-es-elastic-user -o go-template='{{.data.elastic | base64decode}}')

kubectl port-forward service/quickstart-es-http 9200

curl -u "elastic:$PASSWORD" -k "https://localhost:9200"

# Deploy a Kibana instance
cat <<EOF | kubectl apply -f -
apiVersion: kibana.k8s.elastic.co/v1
kind: Kibana
metadata:
  name: quickstart
spec:
  version: 7.13.2
  count: 1
  elasticsearchRef:
    name: quickstart
EOF

kubectl get kibana

kubectl get service quickstart-kb-http

kubectl port-forward service/quickstart-kb-http 5601

用户名：elastic
密码：
kubectl get secret quickstart-es-elastic-user -o=jsonpath='{.data.elastic}' | base64 --decode; echo


cat <<EOF | kubectl apply -f -
apiVersion: beat.k8s.elastic.co/v1beta1
kind: Beat
metadata:
  name: quickstart
spec:
  type: filebeat
  version: 7.13.2
  elasticsearchRef:
    name: quickstart
  config:
    filebeat.inputs:
    - type: log
      paths:
      - /var/apps/log/*.log
  daemonSet:
    podTemplate:
      spec:
        dnsPolicy: ClusterFirstWithHostNet
        hostNetwork: true
        securityContext:
          runAsUser: 0
        containers:
        - name: filebeat
          volumeMounts:
          - name: varlogcontainers
            mountPath: /var/apps/log
        volumes:
        - name: varlogcontainers
          hostPath:
            path: /var/apps/log
EOF