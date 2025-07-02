locals {
  region         = "us-west-2"
  instance_type  = "t2.micro"
  ami = "ami-020cba7c55df1f615"
  az_count       = 2
  vpc_cidr       = "10.0.0.0/16"
}