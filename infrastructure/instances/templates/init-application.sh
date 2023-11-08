#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
aws ecr get-login-password --region ${registry_region} | docker login --username AWS --password-stdin ${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
docker pull ${repo_url}:${app_version}
sudo docker run -p 80:8000 -d 980413755349.dkr.ecr.eu-central-1.amazonaws.com/app_image:latest