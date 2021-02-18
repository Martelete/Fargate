# Bitwarden

Password manger that provides self-hosted options. Due to the nature of this project it has been built a self-hosted.

## Infrastructure as Code (Terraform)

The infrastructure consists in docker containers running serverless (Fargate), on top of that there is a MySQL Database and CloudWatch monitoring.

## How to deploy
For each section described below would be required to run `terraform plan` command to make sure nothing is missing from the initial setup. 

Each resource has the `provider.tf` that have the backend setup in AWS S3 and you need to create a S3 bucket to assign to it.

Below are the following sequences required to deploy this project:

### ACM
First you need to apply the ACM changes made to create a AWS certificate for you in your account. Pay attention on the `variables.tf` file that need to update the value of the hosted zone.

Commands to apply once the udpates are completed:

```
terraform init
terraform plan --out plan
terraform apply plan
```

### VPC
The second part of the deployment is the VPC. No much updates on this side, simply need to run the commands to deploy:

```
terraform init
terraform plan --out plan
terraform apply plan
```

### RDS
The third part of the deployment is the AuroraDB.

```
terraform init
terraform plan --out plan
terraform apply plan
```

### ECS
The ECS is the last section that requires some modifications before you deploy into the code. In `variables.tf` which will require to update the hosted zone details into the field.

Once changes are completed, just run the following commands below:

```
terraform init
terraform plan --out plan
terraform apply plan
```
