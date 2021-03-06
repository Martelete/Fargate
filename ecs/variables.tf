variable "region" {
    default = "eu-west-1"
}

variable "env" {
    default = "prod"
}

# If the average CPU utilization over a minute drops to this threshold,
# the number of containers will be reduced (but not below ecs_autoscale_min_instances).
variable "ecs_as_cpu_low_threshold_per" {
  default = "20"
}

# If the average CPU utilization over a minute rises to this threshold,
# the number of containers will be increased (but not above ecs_autoscale_max_instances).
variable "ecs_as_cpu_high_threshold_per" {
  default = "80"
}

variable "domain_name" {
    description = "The DNS you want to create with wildcard"
    default = ""    ### The hosted zone name with wildcard (i.e. "*.example.com")
}
variable "dns_name" {
    description = "The AWS Route53 Hosted Zone name"
    default = ""    ### The Public hosted zone name without wildcard (i.e. "example.com")
}