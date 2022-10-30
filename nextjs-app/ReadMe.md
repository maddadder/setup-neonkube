1. git clone `https://github.com/maddadder/nextjs-app.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\nextjs-app\virtual-service.yaml --namespace neon-ingress
```
3. deploy image, charts using `deploy.example.cmd`