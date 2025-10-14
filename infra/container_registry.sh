#!/bin/ksh
# Script to create, validate, and delete Azure Container Registry

# Usage:
# ./container_registry.sh create <RESOURCE_GROUP> <REGISTRY_NAME> <LOCATION> [SKU]
# ./container_registry.sh validate <RESOURCE_GROUP> <REGISTRY_NAME>
# ./container_registry.sh delete <RESOURCE_GROUP> <REGISTRY_NAME>

ACTION=$1
RESOURCE_GROUP=$2
REGISTRY_NAME=$3
LOCATION=$4
SKU=${5:-Basic}   # Default SKU = Basic (can be Basic, Standard, Premium)

# Function to create container registry
create_registry() {
    print "Creating Azure Container Registry: $REGISTRY_NAME in $RESOURCE_GROUP ($LOCATION)..."
    az acr create \
        --resource-group "$RESOURCE_GROUP" \
        --name "$REGISTRY_NAME" \
        --sku "$SKU" \
        --location "$LOCATION" \
        --admin-enabled true

    if [ $? -eq 0 ]; then
        print "✅ Container Registry '$REGISTRY_NAME' created successfully."
    else
        print "❌ Failed to create Container Registry '$REGISTRY_NAME'."
        exit 1
    fi
}

# Function to validate container registry existence
validate_registry() {
    print "Validating Container Registry: $REGISTRY_NAME..."
    az acr show --resource-group "$RESOURCE_GROUP" --name "$REGISTRY_NAME" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        print "✅ Container Registry '$REGISTRY_NAME' exists in resource group '$RESOURCE_GROUP'."
    else
        print "⚠️ Container Registry '$REGISTRY_NAME' not found in resource group '$RESOURCE_GROUP'."
    fi
}

# Function to delete container registry
delete_registry() {
    print "Deleting Container Registry: $REGISTRY_NAME..."
    az acr delete --name "$REGISTRY_NAME" --resource-group "$RESOURCE_GROUP" --yes

    if [ $? -eq 0 ]; then
        print "🗑️ Container Registry '$REGISTRY_NAME' deleted successfully."
    else
        print "❌ Failed to delete Container Registry '$REGISTRY_NAME'."
        exit 1
    fi
}

# Main execution
case "$ACTION" in
    create)
        if [ $# -lt 4 ]; then
            print "Usage: $0 create <RESOURCE_GROUP> <REGISTRY_NAME> <LOCATION> [SKU]"
            exit 1
        fi
        create_registry
        ;;
    validate)
        if [ $# -lt 3 ]; then
            print "Usage: $0 validate <RESOURCE_GROUP> <REGISTRY_NAME>"
            exit 1
        fi
        validate_registry
        ;;
    delete)
        if [ $# -lt 3 ]; then
            print "Usage: $0 delete <RESOURCE_GROUP> <REGISTRY_NAME>"
            exit 1
        fi
        delete_registry
        ;;
    *)
        print "Invalid action. Use one of: create | validate | delete"
        exit 1
        ;;
esac