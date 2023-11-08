#! /bin/bash
sudo yum update -y
sudo yum install -y docker jq
sudo service docker start
sudo usermod -a -G docker ec2-user
cred=$(aws secretsmanager get-secret-value --region ${registry_region} \
    --secret-id ${secret_name} --query SecretString \
    --output text | jq -r .DB_CREDENTIALS)
aws secretsmanager get-secret-value --region ${registry_region} --secret-id ${secret_name}
aws ecr get-login-password --region ${registry_region} | docker login \
    --username AWS \
    --password-stdin https://${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
sudo docker run -d \
    -e REDIS_URL="redis://${redis_instance_ip}:6379/0" \
    -e DB_URL="mongodb://$cred@${mongo_instance_ip}:27017/appdb?authSource=admin" \
    -p 80:8000 \
    --name api-app ${repo_url}:${app_version}