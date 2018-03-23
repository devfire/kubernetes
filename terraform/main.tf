variable "vpc_id" {
  default = "vpc-f03ffe95"
}

variable "security_group_id" {
  default = "sg-9c64e1f9"
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${var.vpc_id}"
  tags {
    Role = "Infrastructure"
  }
}

/*
data "aws_security_group" "default_sg" {
  id = "${var.security_group_id}"
}
*/

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "kubemasters" {
  ami = "${data.aws_ami.amazon_linux.id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  subnet_id = "${element(data.aws_subnet_ids.private.ids,count.index)}"
  key_name = "pf-us-east"
  count = 3
  instance_type = "t2.micro"
  tags {
    Name = "kubemaster"
  }
}

