1. git clone `https://github.com/maddadder/plh.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\plhhoa\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts 
```
cd C:\git\plh
docker-compose build
docker tag 192.168.1.151:32000/plhhoa:1.0.119 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/plhhoa:1.0.119
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/plhhoa:1.0.119

cd C:\Users\alice\.neonkube\tools
helm install plhhoa -f C:\git\plh\plhhoa\values.yaml -f C:\git\setup-neonkube\plhhoa\values.yaml C:\git\plh\plhhoa --namespace leenet
```
