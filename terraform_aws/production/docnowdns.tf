module "acme-reg" {
    source = "../modules/acme-account-registration"
    acme_server_url               = "${var.docnow_acme_server_url}" 
    acme_registration_email       = "${var.docnow_acme_registration_email}"
}

module "dns" {
    source = "../modules/dns/direct"
    dns_domain_name               = "${var.docnow_domain_name}" 
    dns_domain_subdomain          = "${var.docnow_domain_subdomain}" 
    dns_cname_value               = "${module.aws-docnow-env.docnow_env_elb_dnsname}"
}

module "acme-cert" {
    source = "../modules/acme-cert-request"
    acme_server_url                 = "${var.docnow_acme_server_url}" 
    acme_account_registration_url   = "${module.acme-reg.registration_url}"
    acme_account_key_pem            = "${module.acme-reg.registration_private_key_pem}"  
    acme_certificate_common_name    = "${module.dns.fqdn_domain_name}"
    # To make use of a single direct DNS record, comment out the line 
    # above, uncomment the one below, and ensure the dns module source
    # is loaded from modules/dns/direct. This current approach has been
    # done to remove a cyclic dependency.
    # acme_certificate_common_name  = "${var.docnow_domain_name}.${var.docnow_domain_subdomain}"

    acme_challenge_aws_access_key_id     = "${var.docnow_acme_challenge_aws_access_key_id}"
    acme_challenge_aws_secret_access_key = "${var.docnow_acme_challenge_aws_secret_access_key}"
    acme_challenge_aws_region            = "${var.docnow_acme_challenge_aws_region}"    
}

module "aws-docnow-env" {
    source = "../modules/aws-docnow-environment"
    docnow_env_nginx_count            = "2"
    docnow_env_cert_body              = "${module.acme-cert.certificate_pem}"      
    docnow_env_cert_chain             = "${module.acme-cert.certificate_issuer_pem}" 
    docnow_env_cert_privkey           = "${module.acme-cert.certificate_private_key_pem}" 
}
