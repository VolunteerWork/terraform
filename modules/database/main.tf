
locals {
  # Chuyển đổi tên để đảm bảo chỉ có chữ cái, số và dấu gạch ngang
  # Convert to ensure that there are only letters, numbers and underscore
  formatted_name = replace(lower("${var.project_name}-${var.env}"), "_", "-")
  
  # Limit database name
  name_prefix = substr(local.formatted_name, 0, min(45, length(local.formatted_name)))
  
  # Recource names
  docdb_subnet_group_name = "${local.name_prefix}-docdb-subnet"
  docdb_cluster_identifier = "${local.name_prefix}-docdb"
}

##########################################
# DB Subnet Groups
##########################################
resource "aws_docdb_subnet_group" "docdb_subnet_group" {
  count       = var.create_documentdb ? 1 : 0
  name        = local.docdb_subnet_group_name
  description = "Database subnet group for DocumentDB"
  subnet_ids  = var.private_data_subnet_ids

  tags = merge(
    {
      Name        = local.docdb_subnet_group_name
      Environment = var.env
    },
    var.tags
  )
   lifecycle {
    create_before_destroy = true
  }
}

resource "aws_docdb_cluster" "docdb" {
  count                         = var.create_documentdb ? 1 : 0
  cluster_identifier            = local.docdb_cluster_identifier
  engine                        = "docdb"
  master_username               = var.docdb_username
  master_password               = var.docdb_password
  backup_retention_period       = 7
  preferred_backup_window       = "02:00-03:00"
  preferred_maintenance_window  = "mon:03:00-mon:04:00"
  skip_final_snapshot           = true
  db_subnet_group_name          = aws_docdb_subnet_group.docdb_subnet_group[0].name
  vpc_security_group_ids        = [var.docdb_sg_id]
  storage_encrypted             = true
  deletion_protection           = var.docdb_deletion_protection
  
  tags = merge(
    {
      Name        = local.docdb_cluster_identifier
      Environment = var.env
    },
    var.tags
  )
}

resource "aws_docdb_cluster_instance" "docdb_instances" {
  count              = var.create_documentdb ? var.docdb_instance_count : 0
  identifier         = "${local.docdb_cluster_identifier}-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb[0].id
  instance_class     = var.docdb_instance_class
  
  tags = merge(
    {
      Name        = "${local.docdb_cluster_identifier}-${count.index}"
      Environment = var.env
    },
    var.tags
  )
}