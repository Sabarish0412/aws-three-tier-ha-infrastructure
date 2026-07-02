# Fetch latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Launch Template for Web Tier
resource "aws_launch_template" "web" {
  name_prefix   = "${var.project_name}-web-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.web_sg_id]
  }

  user_data = base64encode(file("${path.root}/scripts/apache-install.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-web-instance"
    }
  }
}

# Auto Scaling Group for Web Tier
resource "aws_autoscaling_group" "web" {
  name                = "${var.project_name}-web-asg"
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4
  vpc_zone_identifier = [var.public_subnet_1_id, var.public_subnet_2_id]
  target_group_arns   = [var.web_target_group_arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-asg"
    propagate_at_launch = true
  }
}

# Launch Template for App Tier
resource "aws_launch_template" "app" {
  name_prefix   = "${var.project_name}-app-lt-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg_id]
  }

  user_data = base64encode(file("${path.root}/scripts/apache-install.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-app-instance"
    }
  }
}

# Auto Scaling Group for App Tier
resource "aws_autoscaling_group" "app" {
  name                = "${var.project_name}-app-asg"
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4
  vpc_zone_identifier = [var.private_app_subnet_1_id, var.private_app_subnet_2_id]
  target_group_arns   = [var.app_target_group_arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.project_name}-app-asg"
    propagate_at_launch = true
  }
}
