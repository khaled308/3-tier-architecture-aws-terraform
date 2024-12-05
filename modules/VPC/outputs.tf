output "public_subnet_names" {
  value = [for subnet in aws_subnet.public : subnet.tags["Name"]]
}

output "private_subnet_names" {
  value = [for subnet in aws_subnet.private : subnet.tags["Name"]]
}