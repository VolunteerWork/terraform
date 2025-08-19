output "documentdb_endpoint" {
  description = "DocumentDB cluster endpoint"
  value       = aws_docdb_cluster.docdb.endpoint
}

output "documentdb_reader_endpoint" {
  description = "DocumentDB reader endpoint"
  value       = aws_docdb_cluster.docdb.reader_endpoint
}

output "documentdb_port" {
  description = "DocumentDB port"
  value       = aws_docdb_cluster.docdb.port
}

output "documentdb_instance_endpoints" {
  description = "List of DocumentDB instance endpoints"
  value       = try([for instance in aws_docdb_cluster_instance.docdb_instances : instance.endpoint], [])
}