#!/bin/ksh
# ==========================================================
# Script: run.sh
# Purpose: Orchestrate Azure infra scripts
# ==========================================================

set -e  # exit immediately if a command fails

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

# ======== Function to call resource group script ========
run_storage_account() {
    action=$1
    echo "🔹 Running storage account action: $action"
    ./infra/storage_account.sh "$action" "$RESOURCE_GROUP" "$STORAGE_ACCOUNT" \
    "$LOCATION"
}

storage_account_service_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create Storage account"
    echo "2. Validate Storage account"
    echo "3. Delete Storage account"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_storage_account create
            ;;
        2)
            run_storage_account validate
            ;;
        3)
            run_storage_account delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}



run_storage_container() {
    action=$1
    echo "🔹 Running storage container action: $action"
    ./infra/storage_container.sh "$action" "$RESOURCE_GROUP" "$STORAGE_ACCOUNT" \
    "$CONTAINERS"
}

storage_account_container_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create Storage container"
    echo "2. Validate Storage container"
    echo "3. Delete Storage container"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_storage_container create
            ;;
        2)
            run_storage_container validate
            ;;
        3)
            run_storage_container delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}


run_container_registry() {
    action=$1
    echo "🔹 Running container registry action: $action"
    ./infra/container_registry.sh "$action" "$RESOURCE_GROUP" "$REGISTRY_NAME" \
    "$LOCATION"
}

container_registry_service_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create Container registry"
    echo "2. Validate Container registry"
    echo "3. Delete Container registry"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_container_registry create
            ;;
        2)
            run_container_registry validate
            ;;
        3)
            run_container_registry delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}


run_kubernetes_cluster() {
    action=$1
    echo "🔹 Running container registry action: $action"
    ./infra/kubernetes_cluster.sh "$action" "$RESOURCE_GROUP" "$CLUSTER_NAME" \
    "$LOCATION" "$NODE_COUNT" "$NODE_SIZE" "$K8S_VERSION"
}

azure_kubernetes_cluster_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create kubernetes cluster"
    echo "2. Validate kubernetes cluster"
    echo "3. Delete kubernetes cluster"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_kubernetes_cluster create
            ;;
        2)
            run_kubernetes_cluster validate
            ;;
        3)
            run_kubernetes_cluster delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}


run_databricks_cluster() {
    action=$1
    echo "🔹 Running databricks action: $action"
    ./infra/databricks_workspace.sh "$action" "$RESOURCE_GROUP" "$DATABRICKS_WS" \
    "$LOCATION"
}

azure_databricks_service_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create databricks service"
    echo "2. Validate databricsk service"
    echo "3. Delete databricks service"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_databricks_service create
            ;;
        2)
            run_databricks_service validate
            ;;
        3)
            run_databricks_service delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}


run_databricks_cluster() {
    action=$1
    echo "🔹 Running databricks action: $action"
    ./infra/databricks_cluster.sh "$action" "$RESOURCE_GROUP" "$DATABRICKS_WS" \
    "$DATABRICKS_CLUSTER_NAME" "$LOCATION" "$NODE_TYPE" "$SPARK_VERSION" \
    "$NUM_WORKERS"
}

azure_databricks_cluster_type() {
    # ======== Menu for user ========
    echo "=============================================="
    echo " Azure Infrastructure Automation "
    echo "=============================================="
    echo "1. Create databricks cluster"
    echo "2. Validate databricsk cluster"
    echo "3. Delete databricks cluster"
    echo "4. Exit"
    echo "=============================================="
    echo -n "Enter your choice [1-4]: "
    read choice

    case $choice in
        1)
            run_databricks_cluster create
            ;;
        2)
            run_databricks_cluster validate
            ;;
        3)
            run_databricks_cluster delete
            ;;
        4)
            echo "Exiting..."; exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            ;;
    esac
}

# Check input argument
if [ $# -lt 1 ]; then
    echo "❌ Usage: $0 <environment>"
    echo "Example: $0 tst"
    echo "         $0 prd"
    echo "         $0 dev"
    exit 1
fi

ENVIRONMENT=$1

# -----------------------------------------------------------------------------
# Determine config file based on environment
# -----------------------------------------------------------------------------
CONFIG_FILE="$(dirname "$0")/config/${ENVIRONMENT}.config"
echo $CONFIG_FILE

if [ -f "$CONFIG_FILE" ]; then
    echo "📦 Loading configuration for environment: $ENVIRONMENT"
    echo "➡️  Using config file: $CONFIG_FILE"
    . "$CONFIG_FILE"   # Source environment-specific config
else
    echo "❌ Config file not found: $CONFIG_FILE"
    echo "Please create the config file before running this script."
    exit 1
fi

export AZURE_PAT
export RESOURCE_GROUP
export LOCATION
export STORAGE_ACCOUNT
export CONTAINERS
export REGISTRY_NAME
export CLUSTER_NAME
export NODE_COUNT
export NODE_SIZE
export K8S_VERSION
export DATABRICKS_WS
export DATABRICKS_CLUSTER_NAME
export NODE_TYPE
export SPARK_VERSION
export NUM_WORKERS
export DATABRICKS_PAT



# ======== Menu for user ========
echo "=============================================="
echo " Azure Infrastructure Automation. Please select the service "
echo "=============================================="
echo "1. Resource group"
echo "2. Storage account"
echo "3. Storage account containers"
echo "4. Container registry"
echo "5. Azure kubernetes"
echo "6. Azure Databricks"
echo "7. Databricks cluster"
echo "=============================================="
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
        azure_kubernetes_cluster_type
        ;;
    6)
        azure_databricks_service_type
        ;;
    7)
        azure_databricks_cluster_type
        ;;
    8)
        echo "Exiting..."; exit 0
        ;;
    *)
        echo "❌ Invalid choice"
        ;;
esac

