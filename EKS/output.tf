output "endpoint" {
  value = aws_eks_cluster.mycluster.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.mycluster.name
}
