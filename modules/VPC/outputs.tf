output "public_subnet_names" {
  value = [for subnet in aws_subnet.public : subnet.tags["Name"]]
}

output "private_subnet_names" {
  value = [for subnet in aws_subnet.private : subnet.tags["Name"]]
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}