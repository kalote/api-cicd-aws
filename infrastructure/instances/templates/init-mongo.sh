#! /bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker run --rm --name mongo-db \
    --log-driver=awslogs \
    --log-opt awslogs-region=${registry_region} \
    --log-opt awslogs-group=/ec2/logs/mongo \
    --log-opt awslogs-create-group=true \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_PASSWORD=mypassword \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_DATABASE=appdb \
    -d mongo