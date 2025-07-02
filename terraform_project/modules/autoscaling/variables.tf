variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "dev_ex_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "az_count" {
  type = number
}