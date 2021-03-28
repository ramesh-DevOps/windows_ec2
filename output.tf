output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, awsvm is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.windows.*.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.windows.*.public_ip
}

output "private_dns" {
  description = "List of private DNS names assigned to the instances. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.windows.*.private_dns
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.windows.*.private_ip
}
