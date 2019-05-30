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

# }

# resource "null_resource" "takeon" {

  provisioner "local-exec" {
    environment = {
      # Used by all other scripts
      PGPASSWORD="${var.DB_password}"
      PGUSER="${var.DB_username}"
    }
    command = <<EOT
      "psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=${var.DB_username} --password=${var.DB_password} --dbname=validationdb -a -f tables.sql"
      "python generateContributors.py"
      "psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=${var.DB_username} --password=${var.DB_password} --dbname=validationdb -a -f generateResponses.sql"
      "python generateValidationData.py"
    EOT
  }

  # # Load test data into database
  # provisioner "local-exec" {
  #   command = "python generateContributors.py"
  # }

  # provisioner "local-exec" {
  #   command = "psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=${var.DB_username} --password=${var.DB_password} --dbname=validationdb -a -f generateResponses.sql"
  # }

  # provisioner "local-exec" {
  #   command = "python generateValidationData.py"
  # }
}
