# output "cidr_az_key_value" {
#   value = local.flattened_subnet_cidrs
# }

output "public_subnet_ids" {
  value = values(aws_subnet.pub_subnet).*.id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private_subnet).*.id
}
