#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
aws ecr get-login-password --region ${registry_region} | docker login \
    --username AWS \
    --password-stdin https://${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
sudo docker run --name api-app -p 80:8000 -d ${repo_url}:${app_version}