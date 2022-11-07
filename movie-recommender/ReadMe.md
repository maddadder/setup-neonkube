1. git clone `https://github.com/maddadder/movie-recommender.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\movie-recommender\virtual-service.yaml --namespace neon-ingress
```
3. Create the database
```
cd C:\Users\alice\.neonkube\tools
kubectl create -f C:\git\movie-recommender\minimal-postgres-manifest.yaml --namespace leenet
```
4. get the secret of `zalando.acid-minimal-cluster.credentials.postgresql` and save in docker file at C:\git\movie-recommender\flask_app\config2.py
5. Follow instructions in C:\git\movie-recommender\setup-init.cmd
6. deploy image, charts 
```
cd C:\git\movie-recommender
docker-compose build
docker tag 192.168.1.151:32000/movie-recommender:1.0.22 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/movie-recommender:1.0.22
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/movie-recommender:1.0.22

cd C:\Users\alice\.neonkube\tools
helm install movie-recommender -f C:\git\setup-neonkube\movie-recommender\values.yaml C:\git\movie-recommender\movie-recommender --namespace leenet
```
