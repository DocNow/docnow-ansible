/* Security group for the docnow */
resource "aws_security_group" "docnow_server_sg" {
  name        = "${var.environment}-docnow-server-sg"
  description = "Security group for docnow that allows docnow traffic from internet"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-docnow-server-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "docnow_inbound_sg" {
  name        = "${var.environment}-docnow-inbound-sg"
  description = "Allow HTTP from Anywhere"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.environment}-docnow-inbound-sg"
  }
}

/* Docnow servers */
resource "aws_instance" "docnow" {
  count             = "${var.docnow_instance_count}"
  ami               = "${lookup(var.amis, var.region)}"
  instance_type     = "${var.instance_type}"
  subnet_id         = "${var.private_subnet_id}"
  vpc_security_group_ids = [
    "${aws_security_group.docnow_server_sg.id}"
  ]
  key_name          = "${var.key_name}"
  user_data         = "${file("${path.module}/files/user_data.sh")}"
  tags = {
    Name        = "${var.environment}-docnow-${count.index+1}"
    Environment = "${var.environment}"
  }
}

/* Load Balancer */
resource "aws_elb" "docnow" {
  name            = "${var.environment}-docnow-lb"
  subnets         = ["${var.public_subnet_id}"]
  security_groups = ["${aws_security_group.docnow_inbound_sg.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
  healthy_threshold = 2
  unhealthy_threshold = 8
  timeout = 3
  target = "HTTP:80/"
  interval = 180
  }

  instances = ["${aws_instance.docnow.*.id}"]
  connection_draining = true
  idle_timeout = 400
  connection_draining_timeout = 400

  tags {
    Environment = "${var.environment}"
  }
}
