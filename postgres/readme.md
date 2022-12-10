### Configure postgres backup

1. Go to the deployment.yaml file and update the `PGPASSWORD` environment variable with the `postgres` password.
2. Update the server from `192.168.1.65` to the correct ip address of your nfs server
3. Update the path from `/myshare` to the correct nfs file share path
4. run `./build.sh` which will also deploy this backup solution
