#! /bin/bash
# Update system
sudo yum update -y
# install docker / jq
sudo yum install -y docker jq
# start service
sudo service docker start
# add ec2-user to docker group
sudo usermod -a -G docker ec2-user
# Retrieving secret and store it in the cred var
cred=$(aws secretsmanager get-secret-value --region ${registry_region} \
    --secret-id ${secret_name} --query SecretString \
    --output text | jq -r .DB_CREDENTIALS)
# Log into ecr
aws ecr get-login-password --region ${registry_region} | docker login \
    --username AWS \
    --password-stdin https://${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
# Run the app
docker run -d \
    -e REDIS_URL="redis://${redis_instance_ip}:6379/0" \
    -e DB_URL="mongodb://$cred@${mongo_instance_ip}:27017/appdb?authSource=admin" \
    -p 80:8000 \
    --name api-app ${repo_url}:${app_version}