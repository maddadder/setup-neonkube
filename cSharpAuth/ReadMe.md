1. git clone `https://github.com/maddadder/cSharpAuth.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\cSharpAuth\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts 
```
cd C:\git\cSharpAuth
docker-compose build
docker tag 192.168.1.151:32000/csharpauth:1.0.78 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/csharpauth:1.0.78
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/csharpauth:1.0.78

cd C:\Users\alice\.neonkube\tools
helm install csharpauth -f C:\git\cSharpAuth\csharpauth\values.yaml -f C:\git\setup-neonkube\cSharpAuth\values.yaml C:\git\cSharpAuth\csharpauth --namespace leenet
```
