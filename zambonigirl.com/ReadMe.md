1. git clone `https://github.com/maddadder/zambonigirl.com.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\zambonigirl.com\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts 
```
cd C:\git\zambonigirl.com
docker-compose build
docker tag 192.168.1.151:32000/zambonigirl:1.0.11 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/zambonigirl:1.0.11
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/zambonigirl:1.0.11

cd C:\Users\alice\.neonkube\tools
helm install zambonigirl -f C:\git\setup-neonkube\zambonigirl.com\values.yaml C:\git\zambonigirl.com\zambonigirl --namespace leenet
```
