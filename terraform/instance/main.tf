resource "aws_instance" "main" {
  ami                         = "${var.ami}"
  availability_zone           = "${var.availability_zone}"
  instance_type               = "t2.micro"
  monitoring                  = "${var.monitoring}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  key_name                    = "${var.key_name}"
  tenancy                     = "${var.tenancy}"
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = "${var.subnet_id}"

}