locals {
  subnet_count = length(local.subnets)
}
resource "aws_instance" "awsvm" {
  count                  = local.instance_count
  ami                    = local.ami
  key_name               = local.key_name
  instance_type          = local.type
  vpc_security_group_ids = [aws_security_group.Instance_SG.id]
  subnet_id              = local.subnets
  
  connection{
  type = "winrm"
  user = "Administrator"
  password = "${var.admin_password}"
  }
  
  tags = merge(
    {
      "Name"  = local.subnet_count > 1 || local.use_num_suffix ? format("%s${local.num_suffix_format}", local.product, count.index + 1) : var.product
      "Stack" = local.stack
    }
  )
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
  instancs_list = length(aws_instance.awsvm.*.id)

}
locals {
  instance_count             = var.instance_count
  ami                        = "ami-0afcbc82a6a511e53"
  key_name                   = "windows-key"
  type                       = var.type
  use_num_suffix             = var.use_num_suffix
  product                    = var.product
  num_suffix_format          = var.num_suffix_format
  stack                      = var.stack
  subnets                    = "subnet-2708aa5f"
  idle_timeout               = 60
  enable_deletion_protection = false
  vpc_id                     = "vpc-4700503f"
}

