# printing ec2 instance public ip
output "ec2-public-ip" {
  value       = "public: ${aws_instance.web.public_ip}"
  sensitive   = false
  description = "printing public ip for ec2 instance"
  depends_on  = []
}