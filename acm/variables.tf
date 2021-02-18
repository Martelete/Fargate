variable "region" {
    description = "Your AWS region"
    default = "eu-west-1"
}

variable "domain_name" {
    description = "The DNS you want to create with wildcard"
    default = ""    ### The hosted zone name with wildcard (i.e. "*.example.com")
}
variable "zone_name" {
    description = "The AWS Route53 Hosted Zone name"
    default = ""    ### The Public hosted zone name without wildcard (i.e. "example.com")
}