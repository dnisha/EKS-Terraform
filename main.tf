module "Networking" {
  source               = "./Networking"
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "Role" {
  source               = "./IamRole"
}

module "EKS" {
  source               = "./EKS"
  controlPlane_subnet_ids = module.Networking.public_subnet_ids
  controlPlane_role_arn = module.Role.eks_cluster_role_arn
  node_subnet_ids = module.Networking.private_subnet_ids
  node_role_arn = module.Role.eks_node_role_arn
}