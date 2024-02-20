resource "aws_eks_cluster" "mycluster" {
  name     = "demo-cluster"
  role_arn = var.controlPlane_role_arn

  vpc_config {
    subnet_ids = var.controlPlane_subnet_ids
  }
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region us-east-1 update-kubeconfig --name ${aws_eks_cluster.mycluster.name}"
  }

  depends_on = [ aws_eks_cluster.mycluster ]
}