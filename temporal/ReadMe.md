1. `cd c:\git`
2. `git clone https://github.com/temporalio/helm-charts`
3. `cd C:\Users\alice\.neonkube\tools`
4. `kubectl apply -f C:\git\setup-neonkube\temporal\namespace.yaml`
5. `helm dependencies update C:\git\helm-charts`
6. `helm install --set server.replicaCount=1 --set cassandra.config.cluster_size=1 --set prometheus.enabled=false --set grafana.enabled=false --set elasticsearch.enabled=false temporaltest C:\git\helm-charts -f C:\git\setup-neonkube\temporal\helm-charts\values.yaml --timeout 15m --namespace temporal`
7. `kubectl apply -f C:\git\setup-neonkube\temporal\virtual-service.yaml`
8. Navigate to https://temporal.leenet.link/ to test web
9. exec into temporal admin tools and run: `tctl namespace register default`
