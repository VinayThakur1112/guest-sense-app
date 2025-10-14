#!/bin/ksh
# ==========================================================
# Script: storage_container.sh
# Purpose: Manage Azure Blob Containers in a Storage Account
# Usage: ./storage_container.sh <create|delete|validate> <resource_group> <storage_account> <container1,container2,...>
# ==========================================================

set -e

ACTION=$1
RESOURCE_GROUP=$2
STORAGE_ACCOUNT=$3
CONTAINERS=$4

if [ -z "$ACTION" ] || [ -z "$RESOURCE_GROUP" ] || [ -z "$STORAGE_ACCOUNT" ] || [ -z "$CONTAINERS" ]; then
  echo "Usage: $0 <create|delete|validate> <resource_group> <storage_account> <container1,container2,...>"
  exit 1
fi

# Retrieve storage account key (needed for container operations)
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group "$RESOURCE_GROUP" \
  --account-name "$STORAGE_ACCOUNT" \
  --query "[0].value" -o tsv 2>/dev/null)

if [ -z "$ACCOUNT_KEY" ]; then
  echo "❌ Failed to fetch storage account key. Check if the storage account '$STORAGE_ACCOUNT' exists."
  exit 1
fi

# Convert comma-separated container names into a list
IFS=',' read -r -A container_array <<< "$CONTAINERS"

case $ACTION in
  create)
    echo "🚀 Creating containers in storage account: $STORAGE_ACCOUNT"
    for container in "${container_array[@]}"; do
      echo "➡️ Creating container: $container"
      az storage container create \
        --name "$container" \
        --account-name "$STORAGE_ACCOUNT" \
        --account-key "$ACCOUNT_KEY" \
        --public-access off \
        --output table
    done
    echo "✅ All containers created successfully."
    ;;

  validate)
    echo "🔍 Validating containers in storage account: $STORAGE_ACCOUNT"
    for container in "${container_array[@]}"; do
      echo "➡️ Checking container: $container"
      if az storage container show \
        --name "$container" \
        --account-name "$STORAGE_ACCOUNT" \
        --account-key "$ACCOUNT_KEY" \
        --output table >/dev/null 2>&1; then
        echo "✅ Container '$container' exists."
      else
        echo "❌ Container '$container' not found."
      fi
    done
    ;;

  delete)
    echo "🧹 Deleting containers in storage account: $STORAGE_ACCOUNT"
    for container in "${container_array[@]}"; do
      echo "➡️ Deleting container: $container"
      az storage container delete \
        --name "$container" \
        --account-name "$STORAGE_ACCOUNT" \
        --account-key "$ACCOUNT_KEY" \
        --yes \
        --output none || echo "⚠️ Could not delete container $container (may not exist)."
    done
    echo "✅ Deletion completed."
    ;;

  *)
    echo "❌ Invalid action. Use create, validate, or delete."
    exit 1
    ;;
esac    