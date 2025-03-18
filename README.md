# Serverless RDS Cluster Automation

![Blank diagram](https://github.com/user-attachments/assets/dd4d898d-bfd5-43b1-ac66-788b80cb8a75)

## Overview

**This project** provides an automated solution for provisioning Amazon RDS clusters using **AWS serverless architecture** and **Infrastructure as Code (IaC)**. The automation is designed for developers to easily request RDS clusters via an API endpoint, supporting:

- **Database Name**
- **Database Engine** (MySQL, PostgreSQL)
- **Environment** (Dev/Prod) — determines cluster size

### Key Features

✅ **AWS SAM** for serverless deployment\
✅ **Terraform** for RDS provisioning\
✅ **Lambda function** for GitHub PR creation\
✅ **CircleCI** for automated CI/CD pipeline\
✅ **Secure storage** of credentials using AWS Secrets Manager\
✅ **Automated cleanup** of RDS clusters

---

## Architecture

### AWS Services Used:

- **API Gateway** – Exposes an endpoint for developers to request RDS clusters.
- **SNS & SQS** – Ensures reliable and decoupled message processing.
- **Lambda Functions** – Handles SNS publishing, SQS consumption (for PR creation), and RDS cleanup.
- **Terraform** – Provisions RDS clusters via code managed in GitHub.

---

## Deployment Instructions

### Prerequisites

- **AWS CLI** installed and configured
- **AWS SAM CLI** installed
- **CircleCI account** linked to your GitHub repository
- **Terraform** installed

### Step 1: Clone the Repository
```bash
git clone (https://github.com/chenAmrani/Serverless-RDS-Automation.git)
cd serverless-rds-automation
```

(*Note: Replace **`<repository_url>`** with your actual repository URL.*)

### Step 2: Install Dependencies

Install Python dependencies using:

```bash
pip install -r requirements.txt
```

### Step 3: Configure AWS SAM

In `samconfig.toml`, ensure the parameters match your environment:

```toml
stack_name = "serverless-rds"
region = "us-east-1"
confirm_changeset = true
capabilities = "CAPABILITY_IAM"
```

### Step 4: Deploy SAM Stack

Run the following command to deploy the AWS SAM stack:

```bash
sam build
sam deploy --guided
```

### Step 5: CircleCI Pipeline (Already Configured)
The CircleCI pipeline is already set up in the `.circleci/config.yml` file and is configured to trigger automatically on PR merge to deploy the SAM stack and apply Terraform changes.

### Step 6: Configure AWS Secrets Manager

Create a new secret in **AWS Secrets Manager** with the name `GITHUB_TOKEN`. Add your GitHub token as the secret value.

---

## How to Use the Automation

### Step 1: Request an RDS Cluster

Send a POST request to the API Gateway endpoint with the following JSON body:

```json
{
  "databaseName": "exampleDB",
  "databaseEngine": "MySQL",
  "environment": "Dev"
}
```

### Step 2: Verify the GitHub PR

- The **Lambda function** will create a new PR in your GitHub repository with the **Terraform configuration** for the RDS cluster.
- **Review and merge** the PR to initiate the Terraform deployment.

### Step 3: Automatic Cleanup 

- RDS clusters will be automatically deleted after **3 hours** (configurable in `RETENTION_PERIOD`).

---

## Best Practices Implemented

✅ **IAM roles** for secure resource access\
✅ Secrets stored in **AWS Secrets Manager**\
✅ **CloudWatch** logging for Lambda functions

---

## Future Enhancements

- Implement additional database engines
- Add enhanced monitoring and alerting
- Extend cleanup logic to handle inactive resources

---

## Troubleshooting

- If deployment fails, verify your AWS SAM stack parameters.
- Ensure your GitHub token is correctly stored in **Secrets Manager**.
- Check **CloudWatch logs** for detailed Lambda function errors.

---

## Author

**Chen** - DevOps Engineer

