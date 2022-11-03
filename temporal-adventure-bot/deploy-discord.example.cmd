set DISCORD_BOT_TOKEN=the_DISCORD_BOT_TOKEN
set COUCHBASE_PASSWORD=the_COUCHBASE_PASSWORD
cd C:\git\temporal-adventure-bot
docker-compose -f C:\git\temporal-adventure-bot\docker-compose.yaml -f C:\git\setup-neonkube\temporal-adventure-bot\docker-compose.yaml build

docker tag 192.168.1.151:32000/temporal-adventure-bot:1.22.130 neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/temporal-adventure-bot:1.22.130
docker push neon-registry.18e7-091a-7bb4-d81e.neoncluster.io/leenet/temporal-adventure-bot:1.22.130
cd C:\Users\alice\.neonkube\tools
helm install temporal-discord-adventure-bot --set couchbasePassword=%COUCHBASE_PASSWORD% --set discordBotToken=%DISCORD_BOT_TOKEN% --values C:\git\temporal-adventure-bot\temporal-adventure-bot\values.yaml --values C:\git\temporal-adventure-bot\temporal-adventure-bot\values.discord.yaml --values C:\git\setup-neonkube\temporal-adventure-bot\values.yaml C:\git\temporal-adventure-bot\temporal-adventure-bot --namespace leenet
