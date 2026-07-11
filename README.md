# 🚀 Infrastructure Automation Platform

An end-to-end Infrastructure as Code (IaC) project that automates Azure infrastructure provisioning, server configuration, and AI-powered deployment reporting using **Terraform**, **Ansible**, **GitHub Actions**, and **Google Gemini**.

---

## 📖 Overview

This project demonstrates an enterprise-style infrastructure automation workflow by provisioning Azure Virtual Machines with Terraform, dynamically generating an Ansible inventory, configuring the infrastructure using Ansible, and producing an AI-generated deployment report using Google Gemini.

The complete deployment lifecycle is orchestrated through a **GitHub Actions Self-Hosted Runner**.

---

## 🏗️ Architecture

```text
                   GitHub Repository
                           │
                           ▼
                GitHub Actions Workflow
                 (Self-Hosted Runner)
                           │
            ┌──────────────┴──────────────┐
            │                             │
            ▼                             ▼
     Terraform Apply               Terraform Destroy
            │
            ▼
Azure Infrastructure (VNet, Subnet, NSG, VMs)
            │
            ▼
Dynamic Ansible Inventory
            │
            ▼
Ansible Configuration
            │
            ▼
Deployment Logs
            │
            ▼
Google Gemini AI
            │
            ▼
Deployment Summary Report
```

---

## ✨ Features

- Infrastructure provisioning using Terraform
- Remote Terraform State Backend on Azure Storage Account
- Modular Terraform configuration
- Dynamic Ansible Inventory generation
- Configuration Management using Ansible Roles
- Self-Hosted GitHub Actions Runner
- Manual **Apply** / **Destroy** workflow
- AI-powered deployment summary using Google Gemini
- Deployment reports uploaded as GitHub Artifacts

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Cloud | Microsoft Azure |
| IaC | Terraform |
| Configuration Management | Ansible |
| CI/CD | GitHub Actions |
| AI | Google Gemini |
| Language | Python |
| Version Control | Git & GitHub |

---

## 📂 Project Structure

```text
.
├── terraform/
│   ├── backend.tf
│   ├── providers.tf
│   ├── compute.tf
│   ├── network.tf
│   ├── outputs.tf
│   └── inventory.tftpl
│
├── ansible/
│   ├── inventory.ini
│   ├── site.yml
│   ├── ansible.cfg
│   └── roles/
│
├── ai/
│   ├── parse_ansible.py
│   ├── summarize.py
│   └── requirements.txt
│
├── reports/
│
├── .github/
│   └── workflows/
│       └── infrastructure.yml
│
└── README.md
```

---

## ⚙️ CI/CD Workflow

The GitHub Actions pipeline performs the following tasks:

1. Validate the self-hosted runner
2. Initialize and validate Terraform
3. Deploy or destroy Azure infrastructure
4. Generate dynamic Ansible inventory
5. Configure servers using Ansible
6. Parse deployment logs
7. Generate an AI deployment summary using Google Gemini
8. Upload reports as GitHub Artifacts

---

## 🔐 Required GitHub Secrets

```
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
GEMINI_API_KEY
```

---

## 🚀 Getting Started

### Clone the Repository

```bash
git clone https://github.com/<your-username>/<repository>.git
cd <repository>
```

### Run the Pipeline

Navigate to:

```
GitHub → Actions → Infrastructure Pipeline
```

Choose one of the following operations:

- **Apply** – Deploy infrastructure and configure servers
- **Destroy** – Remove all deployed resources

---

## 📋 Pipeline Stages

```
Validate
    │
    ▼
Terraform
    │
    ▼
Ansible
    │
    ▼
AI Deployment Report
```

---

## 📊 Outputs

The pipeline generates:

- Azure Infrastructure
- Dynamic Ansible Inventory
- Ansible Execution Log
- Deployment JSON Report
- AI-generated Deployment Summary
- GitHub Actions Job Summary

---

## 🔮 Future Enhancements

- GitHub OIDC Authentication
- Multi-Environment Support (Dev / QA / Prod)
- Prometheus & Grafana Integration
- Security Scanning (Trivy)
- Reusable GitHub Actions Workflows
- Terraform Module Registry

---

## 👨‍💻 Author

**Prashun Chakraborty**

Cloud Infrastructure Engineer | DevOps | Azure | Terraform | Kubernetes | Automation

---

If you found this project useful, feel free to ⭐ the repository.