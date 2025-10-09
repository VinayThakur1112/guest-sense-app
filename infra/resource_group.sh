#!/bin/ksh

# ==========================================================
# Script: manage_resource_group.ksh
# Purpose: Create, validate, and delete Azure Resource Group
# Usage:
#   ./manage_resource_group.ksh create <rg_name> <location>
#   ./manage_resource_group.ksh validate <rg_name>
#   ./manage_resource_group.ksh delete <rg_name>
# ==========================================================

# Exit if any command fails
set -e

# Function to create resource group
create_rg() {
    rg_name=$1
    location=$2

    if [ -z "$rg_name" ] || [ -z "$location" ]; then
        echo "❌ Usage: $0 create <resource_group_name> <location>"
        exit 1
    fi

    echo "🟢 Creating resource group: $rg_name in $location ..."
    az group create --name "$rg_name" --location "$location" --output table
}

# Function to validate resource group existence
validate_rg() {
    rg_name=$1

    if [ -z "$rg_name" ]; then
        echo "❌ Usage: $0 validate <resource_group_name>"
        exit 1
    fi

    echo "🔍 Checking if resource group '$rg_name' exists ..."
    az group show --name "$rg_name" --output table 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "✅ Resource group '$rg_name' exists."
    else
        echo "⚠️ Resource group '$rg_name' not found."
    fi
}

# Function to delete resource group
delete_rg() {
    rg_name=$1

    if [ -z "$rg_name" ]; then
        echo "❌ Usage: $0 delete <resource_group_name>"
        exit 1
    fi

    echo "🗑️ Deleting resource group: $rg_name ..."
    az group delete --name "$rg_name" --yes --no-wait
    echo "🕐 Deletion initiated for '$rg_name'."
}

# Main logic
action=$1
shift

case $action in
    create)
        create_rg "$@"
        ;;
    validate)
        validate_rg "$@"
        ;;
    delete)
        delete_rg "$@"
        ;;
    *)
        echo "Usage:"
        echo "  $0 create <resource_group_name> <location>"
        echo "  $0 validate <resource_group_name>"
        echo "  $0 delete <resource_group_name>"
        exit 1
        ;;
esac