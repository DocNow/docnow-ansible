variable "environment" {
  default = "staging"
}

variable "key_name" {
  description = "The aws keypair to use"
}

variable "region" {
  description = "Region that the instances will be created"
}

variable "availability_zone" {
  description = "The AZ that the resources will be launched"
}

# Networking

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
}

# docnow app
variable "docnow_instance_count" {
  description = "The total of docnow instances to run"
}

# elastic nodes
variable "elastic_instance_count" {
  description = "The total of elastic instances to run"
}

# redis nodes
variable "redis_instance_count" {
  description = "The total of redis instances to run"
}
# Let's Encrypt Account Registration Config
# -- Production
# variable "docnow_acme_server_url"          { default = "https://acme.api.letsencrypt.org/directory"}
# variable "docnow_acme_registration_email"  { default = "your-email@your-company.com" }
# -- Staging
variable "docnow_acme_server_url"          { default = "https://acme-staging.api.letsencrypt.org/directory"}
variable "docnow_acme_registration_email"  { default = "your-email@example.com" }

# Domain against which certificate will be created
# i.e. letsencrypt-terraform.example.com
variable "docnow_domain_name"              { default = "pretendco.com"}
variable "docnow_domain_subdomain"         { default = "letsencrypt-terraform"}

# Leave blank here, supply securely at runtime 
variable "docnow_acme_challenge_aws_access_key_id"     { }
variable "docnow_acme_challenge_aws_secret_access_key" { }
variable "docnow_acme_challenge_aws_region"            { }
