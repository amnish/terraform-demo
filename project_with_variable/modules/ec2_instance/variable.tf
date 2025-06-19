variable "ami_name" {
    description = "This image name"
  
}
variable "instance_type_value" {
    description = "instance type value"
}
variable "aws_region" {
    description = "AWS region to deploy resources"
    type = string
    default = "us-east-1"
  
}
variable "aws_profile" {
    description = "AWS CLI profile to use"
    type = string
    default = "default"
  
}
variable "aws_vpc_value" {
    description = "provide your cidr value"
    default = "vpc-0a0b2c17aba7b3edf"
  
}