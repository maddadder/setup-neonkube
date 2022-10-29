1. Deploy the couchbase operator. The docs for couchbase are located at https://github.com/couchbase-partners/helm-charts
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\namespace.yaml
kubectl apply -f C:\git\setup-neonkube\couchbase\storage-class.yaml
helm repo add couchbase https://couchbase-partners.github.io/helm-charts/
helm repo update
helm install couchbase-operator --values C:\git\setup-neonkube\couchbase\couchbase-operator\values.yaml couchbase/couchbase-operator --namespace couchbase
```
2. Deploy the cluster. The docs are located at: https://docs.couchbase.com/operator/current/howto-couchbase-create.html
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-default-secret.yaml  --namespace couchbase
# NOTE: when you change the password make sure it matches the secret and visa-versa. You should let the operator set the password by updating this secret after it sets the default password via navigating to secrets in k8s in the namespace couchbase, fing my-couchbase-auth and my-couchbase, click on the edit next to the eyeball, paste in your password. The main secret edit button will show you that it base64 encoded it for you.

helm install my-couchbase C:\git\setup-neonkube\couchbase\my-couchbase --namespace couchbase
```

3. configure backup
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-backup.yaml --namespace couchbase
```

### to restore from backup
```
#note: This will restore from the latest backup once applied. You WILL need to flush the bucket before this will work
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-restore.yaml  --namespace couchbase
```

### restore from backup outside of cluster
1. start the backup-exec pod from the server you with to backup from (source)
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-backup-test.yaml --namespace couchbase
```
2. Trigger the job from the step you performed in step 1, and then exec into the pod 
3. `cd /data/backups`
4. Pick the latest backup to perform the following (the filenames I provided are just examples)
```
tar -czf my-couchbase-2022-10-23T03_00_03.tgz my-couchbase-2022-10-23T03_00_03
```
5. Copy tgz file from pod to local filesystem via `kubectl cp pod-name-shown-in-get-pods:path/to/filename.tgz .\local-path\filename.tgz`  using relative paths. Note the pod and filenames are just examples
```
kubectl cp backup-exec-fehjt:data/backups/my-couchbase-2022-10-23T03_00_03.tgz .\my-backup.tgz --namespace couchbase
```
6. head over to your destination and start the backup-exec pod
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-backup-test.yaml --namespace couchbase
```
7. Copy tgz file from local filesystem to destination pod via `kubectl cp .\local-path\filename.tgz pod-name-shown-in-get-pods:path/to/filename.tgz` using relative paths
```
kubectl cp .\my-backup.tgz backup-exec-whw4s:data/backups/my-backup.tgz --namespace couchbase
```
8. exec into destination pod
```
cd data/backups
tar -xvzf my-backup.tgz
```
9. drop the existing collections you have in the bucket (except the default)
9. set `C:\git\setup-neonkube\couchbase\couchbase-restore.yaml` with the correct repo matching the folder, e.g. `my-couchbase-2022-10-23T04_56_39`
10. Flush the couchbase bucket via couchbase => buckets => bucket => edit => advanced bucket settings => flush enable => save changes => flush
10. Apply the restore resource file
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-restore.yaml --namespace couchbase
```
