variable "subnet_name" {
  description = "Name of subnet"
}

variable "availability_zone" {
  description = "Availability zone"
}

variable "vpc_id" {
  description = "The id of the VPC that the desired subnet belongs to"
}

variable "cidr_block" {
  description = "The id of the VPC that the desired subnet belongs to"
}

variable "map_public_ip_on_launch" {
  description = "Map public ip at launch time?"
}
