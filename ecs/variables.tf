variable "region" {
    default = "us-east-1"
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
  default = "*.cmcloudlab1719.info"    ### Add with wildcard (i.e. "*.cmcloudlab1694.info")
}

variable "dns_name" {
  default = "cmcloudlab1719.info"    ### Add with dot at the end (i.e. "cmcloudlab1694.info.")
}