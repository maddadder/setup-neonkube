1. Create the following DNS entries to map to your master node ip
```
192.168.1.181	temporal.leenet.link
192.168.1.181	couchbase.leenet.link
192.168.1.181	couchclient.leenet.link
192.168.1.181	plhhoa-couchclient.leenet.link
192.168.1.181	leenet.link
192.168.1.181	plhhoa.link
192.168.1.181	nextjs-app.leenet.link
192.168.1.181	paintedravendesign.com
192.168.1.181	zambonigirl.com
```
2. Follow instructions in xcp-ng
```
https://neon-k8s.18e7-091a-7bb4-d81e.neoncluster.io/
https://neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/
https://neon-minio.18e7-091a-7bb4-d81e.neoncluster.io/
```
1. Log into minio, Metrics => loki => Manage => Lifecycle => click + on Add lifecycle rule
2. After 3 days, check Expire, click save
3. This will expire logs after n days. My logs filled up in 2 days so feel free to choose 2 days.
4. If your logs fill up before n days you can just go in and delete the index and %cluster-name% folders. The index and %cluster-name% folders will get recreated
```
https://neon-grafana.18e7-091a-7bb4-d81e.neoncluster.io/
To fix grafana sso, go to: 
https://neon-grafana.18e7-091a-7bb4-d81e.neoncluster.io/login/generic_oauth
```
3. Follow instructions in ingress
4. Follow instructions in temporal
5. Follow instructions in registry
6. Follow instructions in couchbase
7. Follow instructions in couchclient
8. Follow instructions in temporal-adventure-bot
9. Follow instructions in cSharpAuth
10. Follow instructions in plhhoa
11. Follow instructions in nextjs-app
12. Follow instructions in paintedravendesign.com
13. Follow instructions in zambonigirl.com
14. Follow instructions in marketcap
15. Follow instructions in ddns-route53
16. Follow instructions in movie-recommender