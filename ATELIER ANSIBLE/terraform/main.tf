terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "fcs_packer" {
  ami           = "ami-08ed5885443d7a7a6"
  instance_type = "t3.micro"
  key_name = "terraform_ec2_key"

  tags = {
    Name = "FCS-PACKER"
  }
}

#resource "aws_instance" "fcs_backend" {
#  ami           = "ami-0dd574ef87b79ac6c"
#  instance_type = "t3.micro"
#  key_name = "terraform_ec2_key"
#
#  tags = {
#    Name = "FCS-Backend"
#  }
#}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = "${file("terraform_ec2_key.pub")}"
}