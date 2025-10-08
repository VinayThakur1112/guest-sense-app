#!/bin/bash
set -e  # exit immediately on error

ACTION=$1
SUBACTION=$2

# ---- Helper Functions ---- #

run_terraform() {
    cd infra/terraform
    case $1 in
        init)
            echo "🔧 Initializing Terraform..."
            terraform init
            ;;
        plan)
            echo "🧩 Planning Terraform..."
            terraform plan
            ;;
        apply)
            echo "🚀 Applying Terraform configuration..."
            terraform apply -auto-approve -var="create_acr=true" \
            -var="create_aks=true"
            ;;
        destroy)
            echo "💣 Destroying Terraform resources..."
            terraform destroy -auto-approve
            ;;
        save_expense)
            echo "💣 Destroying expensive services"
            terraform apply -auto-approve -var="create_acr=false" \
            -var="create_aks=false"
            ;;
        *)
            echo "❌ Unknown Terraform action: $1"
            ;;
    esac
    cd - >/dev/null
}

# ---- Main Controller ---- #

case $ACTION in
    terraform)
        run_terraform $SUBACTION
        ;;
    api)
        run_api $SUBACTION
        ;;
    model)
        run_model $SUBACTION
        ;;
    *)
        echo "Usage:"
        echo "  ./run.sh terraform [init|plan|create_rg|delete_rg]"
        echo "  ./run.sh api [start|stop]"
        echo "  ./run.sh model [train|test]"
        ;;
esac