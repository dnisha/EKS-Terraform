output "public_subnet_ids" {
  value = module.Networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.Networking.private_subnet_ids
}

output "cluster_endpoint" {
  value = module.EKS.endpoint
}
