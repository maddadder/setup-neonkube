### Configure postgres backup

1. Go to the deployment.yaml file and update the `PGPASSWORD` environment variable with the `postgres` password.
2. Update the server from `192.168.1.65` to the correct ip address of your nfs server
3. Update the path from `/myshare` to the correct nfs file share path
4. run `./build.sh` which will also deploy this backup solution

### To backup the files

1. Run the following manually from your client machine every time you want to backup the files
2. TODO: Please automate this process
```
# backup the files from each website onto local PC
kubectl cp leenet/blogifier-plhhoa-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/plhhoa
kubectl cp leenet/blogifier-zambonigirl-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/zambonigirl
kubectl cp leenet/blogifier-pawsnclaws-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/pawsnclaws
kubectl cp leenet/blogifier-paintedravendesign-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/paintedravendesign
kubectl cp leenet/blogifier-ollie-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/ollie
kubectl cp leenet/blogifier-leenet-0:/opt/blogifier/outputs/wwwroot/data ~/Downloads/backups/blogifier/leenet

# Backup from from NTF Server onto local PC
sudo mount 192.168.1.65:/myshare /nfs/home
# Check that the volumne mounted ^
cp -r /nfs/home ~/Downloads/backups/blogifier/backups

```