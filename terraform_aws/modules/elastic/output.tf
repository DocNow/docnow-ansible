output "elastic.ip" {
  value = "${aws_instance.elastic.*.private_ip}"
}
