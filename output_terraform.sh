#!/bin/bash

# Function to initialize Terraform
terraform_init() {
  local dir=$1
  echo "Initializing Terraform in directory: $dir"
  cd "$dir" || exit
  terraform output
  cd - > /dev/null || exit
}


# Initialize Terraform in all directories
terraform_init "rancher-multinode"
terraform_init "vpc"


echo "All Terraform commands executed successfully."
