# Create an on the fly private key for the registration 
resource "tls_private_key" "acme_registration_private_key" {
  algorithm = "RSA"
}

# Set up a registration using the registration private key
resource "acme_registration" "reg" {
  server_url      = "${var.acme_server_url}"
  account_key_pem = "${tls_private_key.acme_registration_private_key.private_key_pem}"
  email_address   = "${var.acme_registration_email}"
}
