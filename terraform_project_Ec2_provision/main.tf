provider "aws" {
    region = "us-east-1"
  
}
module "ec2_instance" {
    source = "./modules/ec2_instance"
    ami_name = "ami-020cba7c55df1f615"
    instance_type_value = "t2.micro"
    subnet_id_value = "subnet-0f1d1060fa7dcd94d"
  
}