output "elb.hostname" {
  value = "${aws_elb.docnow.dns_name}"
}
