1. clone the couchclient repo
```
cd c:\git
git clone https://github.com/maddadder/couchclient.git
```
2. In the `C:\git3\couchclient\src\couchclient`, copy `appsettings.example.json` to `appsettings.leenet.json`
3. In the `C:\git3\couchclient\src\couchclient`, copy `appsettings.example.json` to `appsettings.plhhoa.json`
4. Apply the correct secrets based on the example in step 2 and 3
5. Create the `leenet` namespace
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchclient\namespace.yaml
```
6. Create the virtual service
```
kubectl apply -f C:\git\setup-neonkube\couchclient\virtual-services.yaml --namespace neon-ingress
```
7. deploy plhhoa and leenet image, charts 
```
cd C:\git\couchclient\src\couchclient
docker-compose build
docker tag 192.168.1.151:32000/couchclient:1.0.129 neon-registry.1fcc-fb9d-adea-fda9.neoncluster.io/leenet/couchclient:1.0.129
docker push neon-registry.1fcc-fb9d-adea-fda9.neoncluster.io/leenet/couchclient:1.0.129

cd C:\Users\alice\.neonkube\tools
helm install plhhoa-couchclient -f C:\git\couchclient\couchclient/values.yaml -f C:\git\couchclient\couchclient/values.plhhoa.yaml -f C:\git\setup-neonkube\couchclient\values.yaml C:\git\couchclient\couchclient --namespace leenet

helm install leenet-couchclient -f C:\git\couchclient\couchclient/values.yaml -f C:\git\couchclient\couchclient/values.leenet.yaml -f C:\git\setup-neonkube\couchclient\values.yaml C:\git\couchclient\couchclient --namespace leenet
```
