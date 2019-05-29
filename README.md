# takeon-terraform
Inital AWS Terraform script for Postgresql Database 

# Installing and Setting up Terraform
1. To install Terraform, find the appropriate package for your system and download it. Terraform is packaged as a zip archive.

After downloading Terraform, unzip the package. Terraform runs as a single binary named terraform. Any other files in the package can be safely removed and Terraform will still function.

The final step is to make sure that the terraform binary is available on the PATH. See this page for instructions on setting the PATH on Linux and Mac. This page contains instructions for setting the PATH on Windows.

2. Configure AWS CLI with your user credentials


# Running Terraform
Run *terraform init* to import the different modules and set up remote state. When asked to provide a name for the state file choose the same name as the env value in your terraform.tfvars

Run *terraform plan* to check the output of terraform

Run *terraform apply* to create your infrastructure environment

Run *terraform destroy* to destroy your infrastructure environment
