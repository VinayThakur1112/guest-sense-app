#!/bin/ksh
# ==========================================================
# Script: resource_group.sh
# Purpose: Manage Azure Resource Group
# Usage: ./resource_group.sh <action> <resource_group_name> <location>
# ==========================================================

set -e

ACTION=$1
RG_NAME=$2
LOCATION=$3

if [ -z "$ACTION" ] || [ -z "$RG_NAME" ] || [ -z "$LOCATION" ]; then
  echo "Usage: $0 <create|delete|validate> <resource_group_name> <location>"
  exit 1
fi

case $ACTION in
  create)
    echo "🚀 Creating resource group: $RG_NAME in $LOCATION..."
    az group create --name "$RG_NAME" --location "$LOCATION" --output table
    ;;
  
  delete)
    echo "🧹 Deleting resource group: $RG_NAME..."
    az group delete --name "$RG_NAME" --yes --no-wait
    ;;
  
  validate)
    echo "🔍 Checking if resource group exists: $RG_NAME..."
    az group show --name "$RG_NAME" --output table || echo "❌ Resource group not found."
    ;;
  
  *)
    echo "❌ Invalid action. Use create, delete, or validate."
    exit 1
    ;;
esac