set DDNSR53_CREDENTIALS_ACCESSKEYID=YOUR_ROUTE53_KEY_ID
set DDNSR53_CREDENTIALS_SECRETACCESSKEY=YOUR_ROUTE53_KEY_SECRET

cd C:\Users\alice\.neonkube\tools
helm install ddns-route53 --set Route53AccessKeyId=%DDNSR53_CREDENTIALS_ACCESSKEYID% --set Route53SecretAccessKey=%DDNSR53_CREDENTIALS_SECRETACCESSKEY% C:\git\ddns-route53\ddns-route53 --namespace leenet
