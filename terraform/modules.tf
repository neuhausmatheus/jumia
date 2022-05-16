module "vpc_matheus_neuhaus" {
 source = "./vpc"
 vpc_name = "vpc_matheus_neuhaus"
 cidr_block = "10.10.0.0/16"
 instance_tenancy = "default"
 dns_support = true
 dns_hostnames = true
 enable_classiclink = false
}
module "internet_gateway" {
 source = "./internet_gateway"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
 igw_name = "gw_internet"
}
module "route_table" {
 source = "./route_table"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
}
module "route" {
 source = "./route"
 route_table_id = "${module.route_table.route_table_id}"
 destination_cidr_block = "0.0.0.0/0"
 gateway_id = "${module.internet_gateway.id}"
}
# Declare the data source
data "aws_availability_zones" "available" {}
module "subnet-public-a" {
 source = "./subnet"
 subnet_name = "A_subnet_public_matheus_neuhaus"
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
 cidr_block = "10.10.1.0/24"
 map_public_ip_on_launch = "true"
}
module "subnet-public-b" {
 source = "./subnet"
 subnet_name = "B_subnet_public_matheus_neuhaus"
 availability_zone = "${data.aws_availability_zones.available.names[1]}"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
 cidr_block = "10.10.2.0/24"
 map_public_ip_on_launch = "true"
}
module "subnet-private-a" {
 source = "./subnet"
 subnet_name = "A_subnet_private_matheus_neuhaus"
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
 cidr_block = "10.10.4.0/24"
 map_public_ip_on_launch = "false"
}
module "subnet-private-b" {
 source = "./subnet"
 subnet_name = "B_subnet_private_matheus_neuhaus"
 availability_zone = "${data.aws_availability_zones.available.names[1]}"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
 cidr_block = "10.10.5.0/24"
 map_public_ip_on_launch = "false"
}
module "route_table_association" {
 source = "./route_table_association"
 subnet_id = "${module.subnet-public-a.id}"
 route_table_id = "${module.route_table.route_table_id}"
}
module "elb_security_group" {
 source = "./security_group"
 sg_name = "sg_elb_matheus_neuhaus"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
}
module "elb_http_rule" {
 source = "./security_group_rule"
 type = "ingress"
 from_port = 80
 to_port = 80
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = "${module.elb_security_group.id}"
}
module "sg_vpc_matheus_neuhaus" {
 source = "./security_group"
 sg_name = "sg_vpc_matheus_neuhaus"
 vpc_id = "${module.vpc_matheus_neuhaus.id}"
}
# allow ssh connections
module "ssh_rule_thesis" {
 source = "./security_group_rule"
 type = "ingress"
 to_port = 22
 from_port = 22
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = "${module.sg_vpc_matheus_neuhaus.id}"
}
# allow ssh connections
module "test_rdp_rule_matheus" {
 source = "./security_group_rule"
 type = "ingress"
 to_port = 3389
 from_port = 3389
 protocol = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = "${module.sg_vpc_matheus_neuhaus.id}"
}
# block all other ports
module "test_egress_rule" {
 source = "./security_group_rule"
 type = "egress"
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 security_group_id = "${module.sg_vpc_matheus_neuhaus.id}"
}
module "elb_test_matheus_neuhaus" {
 source = "./elb"
 elbname = "elb_test_matheus_neuhaus"
 subnets = ["${module.subnet-public-a.id}"]
 internal = false
 security_groups = ["${module.elb_security_group.id}"]
 instance_port = 80
 instance_protocol = "tcp"
 lb_port = 80
 lb_protocol = "tcp"
 healthy_threshold = 2
 unhealthy_threshold = 2
 timeout = 3
 target = "TCP:80"
 interval = 30
 cross_zone_load_balancing = true
}
module "ec2" {
 source = "./instance"
 availability_zone = "${data.aws_availability_zones.available.
names[0]}"
 instance_type = "t2.micro"
 monitoring = true
 associate_public_ip_address = true
 key_name = "frontendkey"
 tenancy = "default"
 vpc_security_group_ids = ["${module.sg_vpc_matheus_neuhaus.id}"]
 subnet_id = "${module.subnet-public-a.id}"
 instance_name = "frontend_matheusneuhaus"
}