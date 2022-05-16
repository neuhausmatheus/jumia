variable "region" {
    default = "eu-west-2"
}
 variable "ami" {
   default = "ami-0a244485e2e4ffd03"
}
variable "availability_zone" {
  description = "The availability zone of the Instance."
}

variable "instance_type" {
  default = "t2.micro"
  description = "Type of the instance"
}

variable "monitoring" {
  description = "Monitoring with CloudWatch"
}
variable "associate_public_ip_address" {
  description = "Whether or not the Instance is associated with a public IP address or not"
}
variable "key_name" {
  description = "Name of keypair to instance"
}

variable "tenancy" {
  description = "The tenancy of the instance: dedicate"
}

variable "vpc_security_group_ids" {
  description = "The associated security groups in a non-default VPC"
}

variable "subnet_id" {
  description = "The VPC subnet ID"
}

variable "instance_name" {
  description = "The name of the instance"
}
variable "ansible_role" {
  default = ""
  description = "The role this server has in Ansible"
}

variable "ansible_host_group" {
  default = ""
  description = "The host group this server belongs to in Ansible."
}