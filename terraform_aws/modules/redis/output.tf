output "redis.ip" {
  value = "${aws_instance.redis.*.private_ip}"
}
