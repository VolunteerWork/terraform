##########################################
# DocumentDB outputs
##########################################
output "documentdb_endpoint" {
  description = "DocumentDB cluster endpoint"
  value       = try(aws_docdb_cluster.docdb[0].endpoint, null)
}

output "documentdb_reader_endpoint" {
  description = "DocumentDB reader endpoint"
  value       = try(aws_docdb_cluster.docdb[0].reader_endpoint, null)
}

output "documentdb_port" {
  description = "DocumentDB port"
  value       = try(aws_docdb_cluster.docdb[0].port, null)
}

output "documentdb_instance_endpoints" {
  description = "List of DocumentDB instance endpoints"
  value       = try([for instance in aws_docdb_cluster_instance.docdb_instances : instance.endpoint], [])
}

output "documentdb_username" {
  description = "DocumentDB master username"
  value       = var.create_documentdb ? var.docdb_username : null
}