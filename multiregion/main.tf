terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
alias = "us-east-1"
region = "us-east-1"
}

provider "aws" {
alias = "us-east-2"
region = "us-east-2"
}
resource "aws_instance" "multicloud"{
    ami = "ami-02457590d33d576c3"
    instance_type = "t2.micro"
    provider = "aws.us.east"
}
resource "aws_instance" "multicloud"{
    ami = "ami-02457590d33d576c3"
    instance_type = "t2.micro"
    provider = "aws.us.east.2"
}