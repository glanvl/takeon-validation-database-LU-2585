provider "aws" {
    region = "eu-west-2"
}

resource "aws_db_instance" "takeon" {
    allocated_storage = 5
    storage_type = "gp2"
    engine = "postgres"
    engine_version = 11.1
    instance_class = "db.t3.small"
    name = "validationdb"
    username = "${var.DB_username}"
    password = "${var.DB_password}"
    backup_retention_period = 7
    identifier = "validation-database"
    skip_final_snapshot = true
    publicly_accessible = true

  provisioner "local-exec" {
    command =  "test-data/load_data.sh ${var.DB_username} ${var.DB_password}"
  }
}
