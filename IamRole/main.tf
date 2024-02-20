resource "aws_iam_role" "cluster_role" {
  name                = "eks-cluster-role"
  managed_policy_arns = [data.aws_iam_policy.eks_cluster_policy.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "eks_cluster_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

output "policy" {
  value = data.aws_iam_policy.eks_cluster_policy.arn
}
