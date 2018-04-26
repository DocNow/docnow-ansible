output "elb_hostname" {
  value = "${module.docnow.elb.hostname}"
}

output "bastion_host" {
  value = "${module.networking.bastion.hostname}"
}

output "docnow_ip" {
  value = "${module.docnow.docnow.ip}"
}

output "elastic_ip" {
  value = "${module.elastic.elastic.ip}"
}

output "redis_ip" {
  value = "${module.redis.elastic.ip}"
}
