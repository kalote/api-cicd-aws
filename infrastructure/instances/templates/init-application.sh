#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
echo "aws ecr / docker login"
aws ecr get-login-password --region ${registry_region} | docker login --username AWS --password-stdin ${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
echo "docker run"
docker run -p 80:8000 -d ${repo_url}:${app_version}