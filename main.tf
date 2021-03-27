locals {
  subnet_count = length(local.subnets)
}
resource "aws_instance" "awsvm" {
  count                  = local.instance_count
  ami                    = local.ami
  key_name               = local.key_name
  instance_type          = local.type
  vpc_security_group_ids = local.security_groups
  subnet_id              = local.subnets
  tags = merge(
    {
      "Name"  = local.subnet_count > 1 || local.use_num_suffix ? format("%s${local.num_suffix_format}", local.product, count.index + 1) : var.product
      "Stack" = local.stack
    }
  )
}
locals {
  instancs_list = length(aws_instance.awsvm.*.id)

}
locals {
  instance_count             = var.instance_count
  ami                        = "ami-0afcbc82a6a511e53"
  key_name                   = "windows"
  type                       = var.type
  use_num_suffix             = var.use_num_suffix
  product                    = var.product
  num_suffix_format          = var.num_suffix_format
  stack                      = var.stack
  security_groups            = ["sg-0459543c"]
  subnets                    = "subnet-2c8c3c54"
  idle_timeout               = 60
  enable_deletion_protection = false
  vpc_id                     = "vpc-5efdda26"
}
