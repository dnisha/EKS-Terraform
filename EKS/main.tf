resource "aws_eks_cluster" "mycluster" {
  name     = "demo-cluster"
  role_arn = var.controlPlane_role_arn

  vpc_config {
    subnet_ids = var.controlPlane_subnet_ids
  }
}


# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.example.certificate_authority[0].data
# }