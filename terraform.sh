#!/bin/bash
# Navigate to Terraform directory
cd ./infra/vultr-terraform

# Execute passed Terraform command
terraform "$@"
