AWS_ACCESS_KEY_ID=replace
AWS_SECRET_ACCESS_KEY=replace
echo ${AWS_SECRET_ACCESS_KEY} > password.txt
kubectl create secret generic aws-route53-creds --from-file=password.txt
rm -f password.txt
