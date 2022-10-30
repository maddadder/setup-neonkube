set COUCHBASE_PASSWORD=THE_COUCHBASE_PASSWORD

cd C:\git\nextjs-app
docker-compose -f C:\git\nextjs-app\docker-compose.yaml -f C:\git\setup-neonkube\nextjs-app\docker-compose.yaml build

docker tag 192.168.1.151:32000/nextjs-app:1.22.76 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/nextjs-app:1.22.76
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/nextjs-app:1.22.76

cd C:\Users\alice\.neonkube\tools
helm upgrade nextjs-app -f C:\git\setup-neonkube\nextjs-app\values.yaml --set couchbasePassword=%COUCHBASE_PASSWORD% C:\git\nextjs-app\nextjs-app --namespace leenet
