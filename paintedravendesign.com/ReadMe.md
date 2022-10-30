1. git clone `https://github.com/maddadder/paintedravendesign.com.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\paintedravendesign.com\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts 
```
cd C:\git\paintedravendesign.com
docker-compose build
docker tag 192.168.1.151:32000/paintedravendesign:1.0.2 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/paintedravendesign:1.0.2
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/paintedravendesign:1.0.2

cd C:\Users\alice\.neonkube\tools
helm install paintedravendesign -f C:\git\setup-neonkube\paintedravendesign.com\values.yaml C:\git\paintedravendesign.com\paintedravendesign --namespace leenet
```
