resource "aws_launch_template" "web_server" {
  name_prefix   = "web-server"
  image_id      = var.ami
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.private_subnet_id
    security_groups             = [var.instance_sg_id]
  }

  tags = {
    Name = "Web Server"
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = [var.private_subnet_id]
  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

 
}
