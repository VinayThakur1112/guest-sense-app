#!/bin/ksh
# ==========================================================
# Script: storage_account.sh
# Purpose: Manage Azure Storage Account
# Usage: ./storage_account.sh <action> <resource_group_name> <storage_account_name> <location>
# ==========================================================

set -e

ACTION=$1
RESOURCE_GROUP=$2
STORAGE_ACCOUNT=$3
LOCATION=$4

if [ -z "$ACTION" ] || [ -z "$RESOURCE_GROUP" ] || [ -z "$STORAGE_ACCOUNT" ] || [ -z "$LOCATION" ]; then
  echo "Usage: $0 <create|delete|validate> <resource_group_name> <storage_account_name> <location>"
  exit 1
fi

case $ACTION in
  create)
    echo "🚀 Creating storage account: $STORAGE_ACCOUNT in $RESOURCE_GROUP ($LOCATION)..."
    az storage account create \
      --name "$STORAGE_ACCOUNT" \
      --resource-group "$RESOURCE_GROUP" \
      --location "$LOCATION" \
      --sku Standard_LRS \
      --kind StorageV2 \
      --enable-hierarchical-namespace true \
      --output table
    echo "✅ Storage account created successfully."
    ;;
  
  validate)
    echo "🔍 Validating if storage account exists: $STORAGE_ACCOUNT..."
    if az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --output table >/dev/null 2>&1; then
      echo "✅ Storage account '$STORAGE_ACCOUNT' exists in resource group '$RESOURCE_GROUP'."
    else
      echo "❌ Storage account '$STORAGE_ACCOUNT' does not exist."
    fi
    ;;
  
  delete)
    echo "🧹 Deleting storage account: $STORAGE_ACCOUNT..."
    az storage account delete --name "$STORAGE_ACCOUNT" --resource-group "$RESOURCE_GROUP" --yes --no-wait
    echo "🕓 Deletion initiated. It may take a few moments."
    ;;
  
  *)
    echo "❌ Invalid action. Use create, validate, or delete."
    exit 1
    ;;
esac