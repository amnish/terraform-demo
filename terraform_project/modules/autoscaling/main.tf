resource "aws_launch_template" "ec2_template" {
  name_prefix   = "ec2-template"
  image_id      = var.ami
  instance_type = var.instance_type
  security_group_names = [var.dev_ex_id]
  key_name      = var.key_name
  monitoring {
    enabled = true
  }
  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo "Hello from EC2" > /var/www/html/index.html
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
  EOF
  )
}

resource "aws_autoscaling_group" "ec2_autoscaling" {
  count               = var.az_count
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [var.private_subnet_ids[count.index]]
  launch_template {
    id      = aws_launch_template.ec2_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  count                  = var.az_count
  autoscaling_group_name = aws_autoscaling_group.ec2_autoscaling[count.index].name
  lb_target_group_arn    = var.target_group_arn
}