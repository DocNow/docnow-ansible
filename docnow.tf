provider "aws" {
    access_key      = "AKIAJGAQJC5KV7GABSZQ"
    secret_key      = "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"
    region          = "us-east-1"
}

resource "aws_instance" "docnow" {
    ami             = "ami-b374d5a5"
    instance_type   = "t2.micro"
}

resource "aws_instance" "docnow2" {
    ami             = "ami-b374d5a5"
    instance_type   = "t2.micro"
}

resource "aws_eip" "ip" {
    instance        = "${aws_instance.docnow.id}"
}
