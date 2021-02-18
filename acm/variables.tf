variable "region" {
    default = "us-east-1"
}

variable "domain_name" {
    description = "The DNS you want to create with wildcard"
    default = "*.cmcloudlab1719.info"    ### the name of the hosted zone displayed in Linux Academy with wildcard (i.e. "*.cmcloudlab1694.info")
}
variable "zone_name" {
    description = "The AWS Route53 Hosted Zone name"
    default = "cmcloudlab1719.info"    ### the hosted zone name, it should be public to access the internet without wildcard (i.e. "cmcloudlab1694.info")
}