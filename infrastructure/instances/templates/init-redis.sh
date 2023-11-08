#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run -d \
    --log-driver=awslogs \
    --log-opt awslogs-region=${registry_region} \
    --log-opt awslogs-group=/ec2/logs/redis \
    --log-opt awslogs-create-group=true \
    -p 6379:6379 \
    -it redis/redis-stack-server:latest