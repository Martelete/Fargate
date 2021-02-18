variable region {
  description = "AWS region where the VPC will be created"
  default     = "us-east-1"
}

variable cidr_base {
  description = "16 first bits of the IPv4 VPC range, see https://checkout.atlassian.net/wiki/spaces/DevOps/pages/411075192/Amazon+Web+Services+-+CKO"
  default     = "10.50."
}