variable "admin_password" {
  description = "password for windows instance"
  default     = "s*-)j3MGQ3Hp=U8o4GVKilvyG64TmCYA"
}
variable "type" {
  type = string
}
resource "aws_instance" "windows" {
  count                  = local.instance_count
  ami                    = local.ami
  key_name               = local.key_name
  instance_type          = var.type
  vpc_security_group_ids = [aws_security_group.Instance_SG.id]
  subnet_id              = local.subnets
  connection{
  type = "winrm"
  port = 5986      
  host = "ec2-54-213-60-118.us-west-2.compute.amazonaws.com"
  user = "Administrator"
  password = "${var.admin_password}"
  https = true
  insecure = true  
  }
  tags = {
     Name = "windows"
  }
}

resource "aws_security_group" "Instance_SG" {
  name        = "Instance-SG"
  description = "Traffic to EC2"
  vpc_id      = local.vpc_id

  ingress {
    description = "instances aws security group"
    from_port   = 5986
    to_port     = 5986
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "instances aws security group"
    from_port   = 5985
    to_port     = 5985
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "instances aws security group"
    from_port   = 3389
    to_port     = 3389
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Instance-SG"
  }
}
locals {
  instance_count             = 1
  ami                        = "ami-0afcbc82a6a511e53"
  key_name                   = "windows-key"
  type                       = "t2.micro"
  subnets                    = "subnet-2708aa5f"
  idle_timeout               = 60
  enable_deletion_protection = false
  vpc_id                     = "vpc-4700503f"
}

