#!/bin/bash

set -e

echo "📦 Initializing Terraform..."
terraform init

echo "📐 Planning Terraform deployment..."
terraform plan -out=tfplan

echo "🚀 Applying Terraform plan..."
terraform apply tfplan
