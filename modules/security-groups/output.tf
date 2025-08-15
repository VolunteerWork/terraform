output "eks_cluster_sg_id" {
  description = "ID của Security Group cho EKS cluster"
  value       = aws_security_group.eks_cluster_sg.id
}
