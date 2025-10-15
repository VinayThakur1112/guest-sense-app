#!/bin/ksh
# ============================================================
# Azure Databricks Cluster Management Script
# ============================================================

# ======= CONFIGURATION =======
ACTION=$1
RESOURCE_GROUP=$2
DATABRICKS_WORKSPACE=$3
CLUSTER_NAME=$4
DATABRICKS_REGION=$5
NODE_TYPE=$6
SPARK_VERSION=$7
NUM_WORKERS=$8
MARKER_FILE=".init_done"

# ============================================================
# ONE-TIME SETUP
# ============================================================
one_time_setup() {
    echo "🔹 Performing one-time setup for Databricks CLI..."

    # Install required tools if missing
    if ! command -v databricks >/dev/null 2>&1; then
        echo "📦 Installing Databricks CLI..."
        pip install databricks-cli || { echo "❌ Databricks CLI install failed"; exit 1; }
    fi

    if ! command -v jq >/dev/null 2>&1; then
        echo "📦 Installing jq..."
        sudo apt-get install -y jq || { echo "❌ jq install failed"; exit 1; }
    fi

    # Optional: Set Azure configuration defaults
    echo "⚙️ Setting Azure config..."
    az config set extension.dynamic_install_allow_preview=true

    # Create the marker file so setup won't repeat
    echo "✅ One-time setup complete."
    echo "Setup done on $(date)" > $MARKER_FILE
}

# ============================================================
# DATARICKS FUNCTIONS
# ============================================================
login_databricks() {
    echo "🔹 Getting Databricks workspace URL..."
    export DATABRICKS_HOST=$(az databricks workspace show \
        --resource-group $RESOURCE_GROUP \
        --name $DATABRICKS_WORKSPACE \
        --query "workspaceUrl" -o tsv)

    echo "🔹 Getting access token..."
    export DATABRICKS_TOKEN=$(az account get-access-token --resource 2ff814a6-3304-4ab8-85cb-cd0e6f879c1d --query accessToken -o tsv)

    if [[ -z "$DATABRICKS_HOST" || -z "$DATABRICKS_TOKEN" ]]; then
        echo "❌ Failed to get Databricks workspace URL or token."
        exit 1
    fi

    echo "✅ Databricks CLI environment configured."
}

get_workspace_url() {
    echo "🚀 Getting Databricks cluster's: $CLUSTER_NAME  URL..."
    az databricks workspace show \
    --resource-group rg-guestsense \
    --name dbw-guestsense \
    --query "workspaceUrl" -o tsv > infra/temp.txt
    echo "✅ WorkspaceUrl saved into temp.txt file."

    WORKSPACE_VAR=$(cat infra/temp.txt)
    rm infra/temp.txt
    echo "✅ temp.txt file is deleted."
    
    WORKSPACE_URL_VAR=https://$WORKSPACE_URL_VAR
    echo "✅ Workspace url formed"
}

create_cluster(){
    echo "🚀 Creating Databricks cluster: $CLUSTER_NAME ..."
    databricks clusters create --json "{
      \"cluster_name\": \"$CLUSTER_NAME\",
      \"spark_version\": \"$SPARK_VERSION\",
      \"node_type_id\": \"$NODE_TYPE\",
      \"num_workers\": $NUM_WORKERS,
      \"autotermination_minutes\": 30
    }"
    echo "✅ Cluster creation command sent. Use 'validate_cluster' to check status."
}

validate_cluster() {
    echo "🔍 Checking clusters..."
    databricks clusters list | grep $CLUSTER_NAME && echo "✅ Cluster exists." || echo "❌ Cluster not found."
}

delete_cluster() {
    echo "🧹 Deleting cluster..."
    CLUSTER_ID=$(databricks clusters list --output JSON | jq -r ".clusters[] | select(.cluster_name==\"$CLUSTER_NAME\") | .cluster_id")
    if [[ -n "$CLUSTER_ID" ]]; then
        databricks clusters delete --cluster-id "$CLUSTER_ID"
        echo "✅ Cluster deleted."
    else
        echo "⚠️ Cluster not found or already deleted."
    fi
}

# ============================================================
# MAIN EXECUTION
# ============================================================
# Run one-time setup if not done before
if [[ ! -f "$MARKER_FILE" ]]; then
    one_time_setup
else
    echo "🟢 One-time setup already done. Skipping..."
fi

if [[ -z "$AZURE_PAT" ]]; then
        echo "❌ Missing Azure Personal Access Token. Please export them before running."
        echo "Example:"
        echo "export DATABRICKS_TOKEN='your_personal_access_token'"
        exit 1
    fi

case $1 in
  create)
    login_databricks
    get_workspace_url
    create_cluster
    ;;
  validate)
    login_databricks
    validate_cluster
    ;;
  delete)
    login_databricks
    delete_cluster
    ;;
  *)
    echo "Usage: $0 {create|validate|delete}"
    exit 1
    ;;
esac