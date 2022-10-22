1. Deploy the couchbase operator. The docs for couchbase are located at https://github.com/couchbase-partners/helm-charts
```
cd C:\Users\alice\.neonkube\tools`
kubectl apply -f C:\git\setup-neonkube\couchbase\namespace.yaml
helm repo add couchbase https://couchbase-partners.github.io/helm-charts/
helm repo update
helm install couchbase-operator --values C:\git\setup-neonkube\couchbase\couchbase-operator\values.yaml couchbase/couchbase-operator --namespace couchbase
```
2. Deploy the cluster. The docs are located at: https://docs.couchbase.com/operator/current/howto-couchbase-create.html
```
kubectl apply -f C:\git\setup-neonkube\couchbase\couchbase-default-secret.yaml  --namespace couchbase
# NOTE: when you change the password make sure it matches the secret and visa-versa. You should let the operator set the password by updating this secret after it sets the default password

# when applying the couchbase-cluster.yaml below, note the nodeselector
# on the backup:. This should match where the pvc mount to
# when the pvc mounts. You should see it in dashboard: 
# persistent volumns > my-backup > 
# label: hostPathProvisionerIdentity: labelname (that matches the node
# that the pv is attached to)
helm install my-couchbase C:\git\setup-neonkube\couchbase\my-couchbase --namespace couchbase
```

### configure backup
```
kubectl apply -f couchbase-backup.yaml
```

### to restore from backup
```
#note: This will restore from the latest backup once applied. You probably need to flush the bucket before this will work
kubectl apply -f couchbase-restore.yaml
```