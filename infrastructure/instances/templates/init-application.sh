#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
<<<<<<< HEAD
echo "aws ecr / docker login"
sudo aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
echo "docker run"
=======
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin ${registry_id}.dkr.ecr.${registry_region}.amazonaws.com
>>>>>>> main
sudo docker run --name mynginx1 -p 80:8000 -d ${repo_url}:${app_version}