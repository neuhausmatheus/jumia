output "public_ip" {
	value = "${aws_instance.main.public_ip}"
}

output "id" {
	value = "${aws_instance.main.id}"
}

output "name" {
	value = "${var.instance_name}"
}

