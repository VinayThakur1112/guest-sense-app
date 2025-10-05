🤖 GuestSense – Data & AI Engineering Project
GuestSense is an end-to-end Data & AI Engineering project designed to simulate a real-world data platform for the hospitality industry.
It focuses on guest experience analytics, semantic insights, and AI-powered features using modern data and cloud engineering practices.
The goal is to help hotels and hospitality businesses understand and improve guest satisfaction by analyzing reviews, feedback, and operational data.


🧩 Project Overview
GuestSense brings together multiple components to create a complete data-to-insight pipeline:
Component                Description
Data Engineering (ETL).  Ingest, clean, and process guest data using Python & Spark
AI & NLP Models.         Perform sentiment analysis, topic clustering, and trend prediction
API Layer                Serve processed insights and predictions to frontend or clients
Infrastructure (Terraform + Azure) Deploy and manage cloud infrastructure using IaC principles
Orchestration (Airflow). Automate and schedule end-to-end data workflows
Monitoring               Track data quality, API uptime, and model performance


⚙️ Tech Stack
Languages & Frameworks
	•	Python 3.12
	•	Flask (API)
	•	PySpark (Data Processing)
	•	scikit-learn / spaCy / Transformers (AI/NLP)

Cloud & Infrastructure
	•	Microsoft Azure
	•	Terraform for IaC
	•	Azure Kubernetes Service (AKS)
	•	Azure Storage Account (ADLS Gen2)
	•	Azure Key Vault
	•	Azure Container Registry (ACR)

Data & Orchestration
	•	Apache Airflow
	•	Azure Synapse / SQL Database
	•	Docker & Kubernetes


📁 Project Structure
guestsense/
├── api/                     # Flask-based REST API
│   └── app.py
├── model/                   # ML and NLP components
│   ├── train_model.py
│   └── predict.py
├── data_pipeline/            # ETL / data transformation logic
│   └── process_data.py
├── infra/                    # Infrastructure as Code
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── scripts/
│           ├── deploy.sh
│           └── destroy.sh
├── run.sh                    # Unified control script
└── README.md                 # Project documentation


☁️ Infrastructure Setup (Terraform on Azure)
This project uses Terraform to automate the provisioning of Azure resources.

To initialize terrafrom
./run.sh terraform init

To initialize terrafrom plan
./run.sh terraform plan

To create terrafrom resourse group
./run.sh terraform create_rg

To delete terrafrom delete_rg
./run.sh terraform delete_rg

