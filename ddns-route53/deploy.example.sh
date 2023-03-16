export DDNSR53_CREDENTIALS_ACCESSKEYID=YOUR_ROUTE53_KEY_ID
export DDNSR53_CREDENTIALS_SECRETACCESSKEY=YOUR_ROUTE53_KEY_SECRET

git clone https://github.com/maddadder/ddns-route53.git
cd ddns-route53
helm install ddns-route53 --namespace leenet --set Route53AccessKeyId=$DDNSR53_CREDENTIALS_ACCESSKEYID --set Route53SecretAccessKey=$DDNSR53_CREDENTIALS_SECRETACCESSKEY ~/git3/ddns-route53/ddns-route53 --namespace leenet
