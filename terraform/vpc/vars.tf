variable "vpc_name" {
  description = "VPC Name"
}
variable "enable_classiclink" {
  description = "Whether or not the VPC has Classiclink enabled"
}
variable "cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
}

variable "dns_support" {
  description = "A tenancy option for instances launched into the VPC"
}

variable "dns_hostnames" {
  description = "A tenancy option for instances launched into the VPC"
}
