output "elb.hostname" {
  value = "${aws_elb.docnow.dns_name}"
}

output "docnow.ip" {
  value = "${aws_instance.docnow.*.private_ip}"
}
