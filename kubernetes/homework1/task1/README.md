```sh
kubectl apply -f node-exporter.yml
```
```sh
kubectl get po  
NAME                             READY   STATUS    RESTARTS   AGE
node-exporter-5c59c6f948-knb7p   1/1     Running   0          16s
```
```sh
kubectl port-forward node-exporter-5c59c6f948-knb7p 9100:9100  
```