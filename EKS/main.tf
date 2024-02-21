resource "aws_eks_cluster" "mycluster" {
  name     = "demo-cluster"
  role_arn = var.controlPlane_role_arn

  vpc_config {
    subnet_ids = var.controlPlane_subnet_ids
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.mycluster.name
  node_group_name = "demo-node"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.node_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.mycluster.name}"
  }

  depends_on = [ aws_eks_cluster.mycluster ]
}

