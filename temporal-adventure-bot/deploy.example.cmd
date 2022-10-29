set SLACK_BOT_TOKEN=the_SLACK_BOT_TOKEN
set SLACK_SIGNING_SECRET=the_SLACK_SIGNING_SECRET
set COUCHBASE_PASSWORD=the_COUCHBASE_PASSWORD

cd C:\git\temporal-adventure-bot
docker-compose -f C:\git\temporal-adventure-bot\docker-compose.yaml -f C:\git\setup-neonkube\temporal-adventure-bot\docker-compose.yaml build

docker tag 192.168.1.151:32000/temporal-adventure-bot:1.22.129 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/temporal-adventure-bot:1.22.129
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/temporal-adventure-bot:1.22.129

cd C:\Users\alice\.neonkube\tools
helm install temporal-adventure-bot --set couchbasePassword=%COUCHBASE_PASSWORD% --set slackBotToken=%SLACK_BOT_TOKEN% --set slackSigningSecret=%SLACK_SIGNING_SECRET% -f C:\git\setup-neonkube\temporal-adventure-bot\values.yaml C:\git\temporal-adventure-bot\temporal-adventure-bot --namespace leenet
