output "public_subnet_ids" {
  value = values(aws_subnet.pub_subnet).*.id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnet).*.id
}
