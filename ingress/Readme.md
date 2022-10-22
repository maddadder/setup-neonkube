1. Deploy secrets
```
cd C:\Users\alice\.neonkube\tools
kubectl create secret generic -n neon-ingress route53-secret --from-literal=secret-access-key="YOUR_KEY_FROM_AWS"
```
2. Deploy cluster issuer, certificates, gateway, virtual services, etc
```
helm install ingress-gateway C:\git\setup-neonkube\ingress\ingress-gateway --namespace neon-ingress
```
3. check the status of the certificate deployments to/from lets encrypt
```
kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
```
