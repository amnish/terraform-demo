output "autoscaling_group_names" {
  value = [for asg in aws_autoscaling_group.ec2_autoscaling : asg.name]
}
