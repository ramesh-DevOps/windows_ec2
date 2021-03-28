##### VM variables #####
variable "instance_count" {
  description = "Number of Instances to Launch"
  type        = number
  default     = 1
}
variable "product" {
  description = "Org Product/Project Name for all Resources as Prefix"
  default     = "Iaac"
}

variable "stack" {
  description = "Org Middleware"
  default     = "Terraform"
}

variable "type" {
  description = "Default Instance Type"
  default     = "t2.micro"
}

variable "use_num_suffix" {
  description = "Always append numerical suffix to instance name, even if instance_count is 1"
  type        = bool
  default     = false
}

variable "num_suffix_format" {
  description = "Numerical suffix format used as the volume and EC2 instance name suffix"
  type        = string
  default     = "-%d"
}

variable "admin_password" {
  description = "password for wnidows instance"
  default     = "project@01"
}
