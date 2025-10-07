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
        apply | create_rg)
            echo "🚀 Applying Terraform configuration..."
            terraform apply -auto-approve
            ;;
        destroy | delete_rg)
            echo "💣 Destroying Terraform resources..."
            terraform destroy -auto-approve
            ;;
        *)
            echo "❌ Unknown Terraform action: $1"
            ;;
    esac
    cd - >/dev/null
}

run_api() {
    case $1 in
        start)
            echo "🌍 Starting Flask API..."
            cd api
            python3 app.py
            ;;
        stop)
            echo "🛑 Stopping API... (use Ctrl+C if running in foreground)"
            ;;
        *)
            echo "❌ Unknown API action: $1"
            ;;
    esac
}

run_model() {
    case $1 in
        train)
            echo "🤖 Training ML model..."
            cd model
            python3 train_model.py
            ;;
        test)
            echo "🧠 Testing model..."
            cd model
            python3 test_model.py
            ;;
        *)
            echo "❌ Unknown model action: $1"
            ;;
    esac
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