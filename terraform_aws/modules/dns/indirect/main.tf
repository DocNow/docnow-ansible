data "aws_route53_zone" "main" {
  name         = "${var.dns_domain_name}"
  private_zone = false
}

resource "aws_route53_record" "letsencrypt-terraform" {
   zone_id = "${data.aws_route53_zone.main.zone_id}"
   name    = "${var.dns_domain_subdomain}.${data.aws_route53_zone.main.name}"
   type    = "CNAME"
   ttl     = "60"
   records = ["tmp-${var.dns_domain_subdomain}.${data.aws_route53_zone.main.name}"]
}

resource "aws_route53_record" "tmp-letsencrypt-terraform" {
   zone_id = "${data.aws_route53_zone.main.zone_id}"
   name    = "tmp-${var.dns_domain_subdomain}.${data.aws_route53_zone.main.name}"
   type    = "CNAME"
   ttl     = "60"
   records = ["${var.dns_cname_value}"]
}
