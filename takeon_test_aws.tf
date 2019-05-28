
# variable "environment_tag" {}
# variable "team_tag" {}
# variable "resource_group" {}
# variable "server_name" {}
# variable "database_name" {}
# variable "user_for_script" {}
# variable "server_password" {} # Need to secure
# variable "server_username" {} # Need to secure

# Configure the Microsoft Azure Provider
provider "aws" {
    region = "eu-west-2"
}

# data "aws_resource_group" "group" {
#     name = "${var.resource_group}"
# }

resource "aws_db_instance" "default" {
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
}

#psql --host=validation-database.cyjaepzpx1tk.eu-west-2.rds.amazonaws.com --port=5432 --username=username --password --dbname=validationdb