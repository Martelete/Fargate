variable "region" {
    description = "AWS Region where the your infrastructure will be created"
    default     = "us-east-1"
}

variable "env" {
  description = "The environment name"
    default   = "prod"
}

variable "db_instance" {
  default = "db.t2.large"
}