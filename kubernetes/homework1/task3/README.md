## Сборка контейнера непосредственно в minikube  
https://minikube.sigs.k8s.io/docs/handbook/pushing/  
## powershell  
```ps
& minikube -p minikube docker-env --shell powershell | Invoke-Expression  
docker build -t get_pods:1.3 .
```
для демонстрации был запущен prometheus из задачи 2