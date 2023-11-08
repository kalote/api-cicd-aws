#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run --name mynginx1 -p 80:8000 -d ${repo_url}:${app_version}