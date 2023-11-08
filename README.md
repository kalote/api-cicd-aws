# CRUD API application

This application is a showcase of using:
- CRUD application (express.js, typescript, mongodb, redis, jest, docker)
- Terraform IaC
- Github Action CICD

# Application

The app is a basic web-server using expressJS and Typescript running on port 8000. It comes with a few tests and a `Dockerfile` to build the docker image.

## run locally

```bash
# Run Redis
docker run -d -p 6379:6379 -it redis/redis-stack-server:latest

# Run mongodb
docker run --rm --name mongo-db -p 27017:27017 \
  -e MONGO_INITDB_ROOT_PASSWORD=mypassword \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_DATABASE=appdb -d mongo
```

```bash
cp .env.example .env # Fill in the values for DB_URL and REDIS_URL
npm i
npm run dev
```

To run the tests:

```bash
npm test
```

To build it run:

```bash
npm run build
```

To run the production version:

```bash
npm start
```

To build the docker image:

```bash
docker build -t crudapi:0.0.1 .
```

# Infrastructure

The infrastructure is managed using IaC Terraform tool.

The `main.tf` is the entry point where the provider and the backend are setup (using S3 for state and DynamoDB for lock). This is also where the modules are called. There are 4 modules:
- state: responsible for the state infrastructure (S3 bucket and DynamoDB table)
- network: handles the VPC creation + 2 subnets (1 private, 1 public) + Internet GW + NAT GW + SG (1 sg for app access / 1 sg for mongo + redis access)
- ecr: creates the ECR registry to host our application docker images
- instances: manages the EC2 instances (1 for the application (public) / 1 for MongoDB (private) / 1 for Redis (private)) + IAM profile + templates used during boot (using the `user-data` attributes)

To deploy the stack, run:

```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

## CICD

The CICD uses GitHub Actions. The config files are located in `.github/workflows`. There are 5 files:

- build-test.yml: triggered for every PR that is not impacting the `infrastructure` folder. The action will build the app and run the tests
- deploy.yml: triggered for every push to main (e.g., when a PR is merged) that i not impacting the `infrastructure` folder. It will connect to ECR using GitHub secrets and build + push the docker image
- infra-plan.yml: triggered for every PR that is impacting the `infrastructure` folder. The action will run terraform plan and comment on the PR with the plan to execute.
- infra-apply.yml: triggered for every push to main (e.g., when a PR is merged) that is impacting the `infrastructure` folder. The action will run terraform apply on the previously validated plan.
- tag-deploy-apply.yml: triggered when a tag is push. It will build + push the docker image with the provided tag and trigger the infra deployment with this tag as the `app_version`.