docker-compose build
docker push neon-registry.d95f-98d9-33df-f8a6.neoncluster.io/leenet/postgres-backup:latest
kubectl apply -f deployment.yaml --namespace leenet
