# Bitwarden

Password manger that provides self-hosted options. Due to the nature of this project it has been built a self-hosted.

## **Important note**

```
This project has been designed to be build in Linux Academy for testing purposes. Please bear in mind that Linux Academy refreshes the configuration every 4 hours and you are not able deploy nothing after this time as the login credentials and the settings on the AWS account will be replaced.

In case you are deploy on your own account, remember to map your configuration accordingly.
```

## Infrastructure as Code (Terraform)

The infrastructure consists in docker container running serverless (Fargate), on top of that there is a Postgres Database and CloudWatch monitoring. This is the architecture for this project:

[Bitwarden Architecture](https://go.gliffy.com/go/html5/13452929)

## How to deploy
For each section described below would be required to run `terraform plan` command to make sure nothing is missing from the initial setup. 

Below are the following sequences required to deploy this project once you have connected to the Linux Academy:

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

### ECS
The ECS is the last section that requires some modifications before you deploy into the code. In `variables.tf` which will require to update the hosted zone details into the field.

Once changes are completed, just run the following commands below:

```
terraform init
terraform plan --out plan
terraform apply plan
```
