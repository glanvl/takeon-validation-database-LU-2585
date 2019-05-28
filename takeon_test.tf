# # Declare variables in takeon.tfvars file stored locally
# variable "subscription_id" {}
# variable "client_id" {}
# variable "client_secret" {}
# variable "tenant_id" {}
# variable "environment_tag" {}
# variable "team_tag" {}
# variable "resource_group" {}
# variable "server_name" {}
# variable "database_name" {}
# variable "user_for_script" {}
# variable "server_password" {} # Need to secure
# variable "server_username" {} # Need to secure

# # Configure the Microsoft Azure Provider
# provider "azurerm" {
#     subscription_id = "${var.subscription_id}"
#     client_id       = "${var.client_id}"
#     client_secret   = "${var.client_secret}"
#     tenant_id       = "${var.tenant_id}"
# }

# # Use existing resource group
# data "azurerm_resource_group" "group" {
#   name = "${var.resource_group}"
# }

# # Create the postgres server resource
# resource "azurerm_postgresql_server" "test" {
#   name                = "${var.server_name}"
#   location            = "${data.azurerm_resource_group.group.location}"
#   resource_group_name = "${data.azurerm_resource_group.group.name}"

#   sku {
#     name     = "B_Gen5_2"
#     capacity = 2
#     tier     = "Basic"
#     family   = "Gen5"
#   }

#   storage_profile {
#     storage_mb            = 5120
#     backup_retention_days = 7
#     geo_redundant_backup  = "Disabled"
#   }

#   tags {
#       "Environment" = "${var.environment_tag}"
#       "Team"        = "${var.team_tag}"
#   }

#   administrator_login          = "${var.server_username}"
#   administrator_login_password = "${var.server_password}"
#   version                      = "10.0"
#   ssl_enforcement              = "Enabled"
# }

# # Create Firewall rule for services to connect
# resource "azurerm_postgresql_firewall_rule" "testOne" {
#   name                = "Azure"
#   resource_group_name = "${data.azurerm_resource_group.group.name}"
#   server_name         = "${azurerm_postgresql_server.test.name}"
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0"
# }

# # Create Firewall rule for AKS to connect
# resource "azurerm_postgresql_firewall_rule" "testTwo" {
#   name                = "Kubernetes"
#   resource_group_name = "${data.azurerm_resource_group.group.name}"
#   server_name         = "${azurerm_postgresql_server.test.name}"
#   start_ip_address    = "10.1.1.4"
#   end_ip_address      = "10.1.1.65"
# }

# # Needed to run scripts
# resource "azurerm_postgresql_firewall_rule" "testThree" {
#   name                = "Public"
#   resource_group_name = "${data.azurerm_resource_group.group.name}"
#   server_name         = "${azurerm_postgresql_server.test.name}"
#   start_ip_address    = "80.5.92.42"
#   end_ip_address      = "80.5.92.42"
# }

# # Create Database
# resource "azurerm_postgresql_database" "test" {
#   name                = "${var.database_name}"
#   resource_group_name = "${data.azurerm_resource_group.group.name}"
#   server_name         = "${azurerm_postgresql_server.test.name}"
#   charset             = "UTF8"
#   collation           = "English_United States.1252"

# # Run Scripts to load data from local machine
# # Ensure you have postgres and python installed to do this (+ Python modules)
# # Need environment variables set to run below scripts
# # PGPASSWORD an important one to run psql
#   provisioner "local-exec" {
#     command = "psql -h takeon.postgres.database.azure.com -U ${var.user_for_script} -d collectiondev -a -f tables.sql"
#     environment {
#       # Used by all other scripts
#       PGPASSWORD = "${var.server_password}"
#     }
#   }

#   # Load test data into database
#   provisioner "local-exec" {
#     command = "python generateContributors.py"
#   }

#   provisioner "local-exec" {
#     command = "psql -h takeon.postgres.database.azure.com -U ${var.user_for_script} -d collectiondev -a -f generateResponses.sql"
#   }

#   provisioner "local-exec" {
#     command = "python generateValidationData.py"
#   }

# }
