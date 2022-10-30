1. git clone marketcap into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\marketcap\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts 
```
cd C:\git\marketcap
docker-compose build
docker tag 192.168.1.151:32000/marketcap:1.0.9 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/marketcap:1.0.9
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/marketcap:1.0.9

cd C:\Users\alice\.neonkube\tools
helm install marketcap -f C:\git\setup-neonkube\marketcap\values.yaml C:\git\marketcap\marketcap --namespace leenet
```
