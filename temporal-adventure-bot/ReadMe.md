1. git clone `https://github.com/maddadder/temporal-adventure-bot.git` into c:\git
2. Create the virtual service
```
cd C:\Users\alice\.neonkube\tools
kubectl apply -f C:\git\setup-neonkube\temporal-adventure-bot\virtual-service.yaml --namespace neon-ingress
```
3. follow instructions in the readme in that repo
4. fill in the environment variable parameters in `deploy.example.cmd` AND/OR `deploy-discord.example.cmd` and run the script(s)
