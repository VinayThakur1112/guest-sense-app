#!/bin/ksh
# ==========================================================
# Script: run.sh
# Purpose: Orchestrate Azure infra scripts
# ==========================================================

set -e  # exit immediately if a command fails

# ======== Configurable variables ========
RESOURCE_GROUP="rg-guestsense"
LOCATION="centralindia"

# ======== Function to call resource group script ========
run_resource_group() {
    action=$1
    echo "🔹 Running resource group action: $action"
    ./infra/resource_group.sh "$action" "$RESOURCE_GROUP" "$LOCATION"
}

resoruce_group_service_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create Resource Group"
    echo "2. Validate Resource Group"
    echo "3. Delete Resource Group"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_resource_group create
            ;;
        2)
            run_resource_group validate
            ;;
        3)
            run_resource_group delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}


storage_account_service_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create Resource Group"
    echo "2. Validate Resource Group"
    echo "3. Delete Resource Group"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_resource_group create
            ;;
        2)
            run_resource_group validate
            ;;
        3)
            run_resource_group delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}



# ======== Menu for user ========
echo "=============================================="
echo " Azure Infrastructure Automation. Please select the service "
echo "=============================================="
echo "1. Resource group"
echo "2. Storage account"
echo "3. Storage account containers"
echo "4. Container registry"
echo "5. Azure kubernetes"
echo "=============================================="
echo -n "Enter your choice [1-4]: "
read choice

case $choice in
    1)
        resoruce_group_service_type
        ;;
    2)
        storage_account_service_type
        ;;
    3)
        storage_account_container_type
        ;;
    4)
        container_registry_service_type
        ;;
    5)
        azure_kubernetes_service_type
        ;;
    6)
        echo "Exiting..."; exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        ;;
esac

