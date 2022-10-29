1. Install docker/docker desktop
2. Log into: https://neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/
3. Create a new private project called `leenet`
4. Make sure you are logged into the registry via 
```
echo neon-registry.18e7-091a-7bb4-d81e.neoncluster.io | docker-credential-desktop get
```
5. If you get `credentials not found in native keychain` then type: 
```docker login neon-registry.18e7-091a-7bb4-d81e.neoncluster.io -u root```
6. retry step 4 to verify you are logged in
7. create image pull secrets https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/#create-a-secret-by-providing-credentials-on-the-command-line
```
cd C:\Users\alice\.neonkube\tools
kubectl create secret docker-registry leenet-registry --docker-server=https://neon-registry.18e7-091a-7bb4-d81e.neoncluster.io --docker-username=root --docker-password=<your-root-pword> --docker-email=<your-email> --namespace leenet
```
