#!/bin/ksh
# Script to create, validate, and delete Azure Kubernetes Service (AKS) cluster

# Usage:
# ./kubernetes_cluster.sh create <RESOURCE_GROUP> <CLUSTER_NAME> <LOCATION> <NODE_COUNT> <NODE_SIZE> <K8S_VERSION>
# ./kubernetes_cluster.sh validate <RESOURCE_GROUP> <CLUSTER_NAME>
# ./kubernetes_cluster.sh delete <RESOURCE_GROUP> <CLUSTER_NAME>

ACTION=$1
RESOURCE_GROUP=$2
CLUSTER_NAME=$3
LOCATION=$4
NODE_COUNT=${5:-2}
NODE_SIZE=${6:-Standard_DS2_v2}
K8S_VERSION=${7:-1.32.7}

# Function to create AKS cluster
create_aks() {
    print "Creating AKS Cluster: $CLUSTER_NAME in resource group $RESOURCE_GROUP ($LOCATION)..."
    az aks create \
        --resource-group "$RESOURCE_GROUP" \
        --name "$CLUSTER_NAME" \
        --node-count "$NODE_COUNT" \
        --node-vm-size "$NODE_SIZE" \
        --location "$LOCATION" \
        --generate-ssh-keys \
        --kubernetes-version "$K8S_VERSION" \
        --enable-managed-identity

    if [ $? -eq 0 ]; then
        print "✅ AKS Cluster '$CLUSTER_NAME' created successfully."
    else
        print "❌ Failed to create AKS Cluster '$CLUSTER_NAME'."
        exit 1
    fi
}

# Function to validate AKS cluster existence
validate_aks() {
    print "Validating AKS Cluster: $CLUSTER_NAME..."
    az aks show --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        print "✅ AKS Cluster '$CLUSTER_NAME' exists in resource group '$RESOURCE_GROUP'."
    else
        print "⚠️ AKS Cluster '$CLUSTER_NAME' not found in resource group '$RESOURCE_GROUP'."
    fi
}

# Function to delete AKS cluster
delete_aks() {
    print "Deleting AKS Cluster: $CLUSTER_NAME..."
    az aks delete --resource-group "$RESOURCE_GROUP" --name "$CLUSTER_NAME" --yes --no-wait

    if [ $? -eq 0 ]; then
        print "🗑️ AKS Cluster '$CLUSTER_NAME' deletion initiated successfully."
    else
        print "❌ Failed to delete AKS Cluster '$CLUSTER_NAME'."
        exit 1
    fi
}

# Main execution
case "$ACTION" in
    create)
        if [ $# -lt 4 ]; then
            print "Usage: $0 create <RESOURCE_GROUP> <CLUSTER_NAME> <LOCATION> [NODE_COUNT] [NODE_SIZE] [K8S_VERSION]"
            exit 1
        fi
        create_aks
        ;;
    validate)
        if [ $# -lt 3 ]; then
            print "Usage: $0 validate <RESOURCE_GROUP> <CLUSTER_NAME>"
            exit 1
        fi
        validate_aks
        ;;
    delete)
        if [ $# -lt 3 ]; then
            print "Usage: $0 delete <RESOURCE_GROUP> <CLUSTER_NAME>"
            exit 1
        fi
        delete_aks
        ;;
    *)
        print "Invalid action. Use one of: create | validate | delete"
        exit 1
        ;;
esac