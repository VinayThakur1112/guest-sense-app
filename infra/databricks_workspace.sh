#!/bin/ksh

# === CONFIG ===
ACTION=$1
RESOURCE_GROUP=$2
DATABRICKS_WS=$3
LOCATION=$4

# === CREATE FUNCTION ===
create_databricks_workspace() {
  echo "Creating Azure Databricks workspace..."

  az config set extension.dynamic_install_allow_preview=true
  az databricks workspace create \
    --name $DATABRICKS_WS \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku standard
}

# === VALIDATE FUNCTION ===
validate_databricks_workspace() {
  echo "Validating Databricks workspace..."
  az databricks workspace show \
    --name $DATABRICKS_WS \
    --resource-group $RESOURCE_GROUP \
    --query "{name:name, location:location, sku:sku}" \
    --output table
}

# === DELETE FUNCTION ===
delete_databricks_workspace() {
  echo "Deleting Databricks workspace..."
  az databricks workspace delete \
    --name $DATABRICKS_WS \
    --resource-group $RESOURCE_GROUP \
    --yes
}

# === MAIN SWITCH ===
case "$ACTION" in
  create) create_databricks_workspace ;;
  validate) validate_databricks_workspace ;;
  delete) delete_databricks_workspace ;;
  *) echo "Usage: $0 {create|validate|delete}" ;;
esac