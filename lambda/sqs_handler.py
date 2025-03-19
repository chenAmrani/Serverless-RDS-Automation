import json
import boto3
import logging
import requests
import base64
import os
from github import Github  
import random
import string  

logger = logging.getLogger()
logger.setLevel(logging.INFO)

rds_client = boto3.client('rds')
secrets_manager_client = boto3.client('secretsmanager')

def get_github_token():
    client = boto3.client('secretsmanager')
    secret_name = "GITHUB_TOKEN"
    try:
        response = client.get_secret_value(SecretId=secret_name)
        secret_value = json.loads(response['SecretString'])['GITHUB_TOKEN'] 
        logger.info(f"✅ Successfully retrieved GitHub Token: {secret_value[:5]}******")  
        return secret_value
    except Exception as e:
        logger.error(f"❌ Error retrieving GitHub token: {e}")
        raise

github_token = get_github_token()

def generate_password(length=12):
    characters = string.ascii_letters + string.digits + "!@#$%^&*"
    return ''.join(random.choices(characters, k=length))

def create_secret(secret_name, password):
    try:
        secrets_manager_client.create_secret(
            Name=secret_name,
            SecretString=json.dumps({"password": password})
        )
        logger.info(f"✅ Secret '{secret_name}' created successfully.")
    except secrets_manager_client.exceptions.ResourceExistsException:
        logger.warning(f"⚠️ Secret '{secret_name}' already exists. Skipping creation.")

def generate_terraform_code(message_body):
    instance_class = "db.t3.micro" if message_body['environment'].lower() == "dev" else "db.t3.medium"
    allocated_storage = 20 if message_body['environment'].lower() == "dev" else 100

    secret_name = f"mysql/{message_body['databaseName']}/DB_CREDENTIALS"
    password = generate_password()

    create_secret(secret_name, password)

    auto_delete_tag = ''
    if message_body['environment'].lower() == 'prod':
        auto_delete_tag = 'AutoDelete = "True"\n'

    return f"""
data "aws_secretsmanager_secret" "db_password" {{
  name = "{secret_name}"
}}

data "aws_secretsmanager_secret_version" "latest" {{
  secret_id = data.aws_secretsmanager_secret.db_password.id
}}

resource "aws_db_instance" "{message_body['databaseName']}" {{
  identifier       = "{message_body['databaseName']}"
  engine           = "{message_body['engine'].lower()}"
  instance_class   = "{instance_class}"
  allocated_storage = {allocated_storage}

  username         = "admin"           
  password         = jsondecode(data.aws_secretsmanager_secret_version.latest.secret_string)["password"]

  tags = {{
    Environment = "{message_body['environment'].capitalize()}"
    {auto_delete_tag}
  }}
}}
"""

def create_github_pr(message_body):
    repo_name = "chenAmrani/Serverless-RDS-Automation"
    branch_name = f"feature/create-{message_body['databaseName']}"

    g = Github(github_token)
    repo = g.get_repo(repo_name)

    source = repo.get_branch("main")
    repo.create_git_ref(ref=f"refs/heads/{branch_name}", sha=source.commit.sha)

    terraform_code = generate_terraform_code(message_body)
    repo.create_file(
        f"terraform/{message_body['databaseName']}_main.tf",
        f"Add RDS instance for {message_body['databaseName']}",
        terraform_code,
        branch=branch_name
    )

    pr = repo.create_pull(
        title=f"Add RDS instance for {message_body['databaseName']}",
        body="This PR adds a new RDS instance as requested.",
        head=branch_name,
        base="main"
    )

    logger.info(f"✅ PR created successfully: {pr.html_url}")
    return pr.html_url

def lambda_handler(event, context):
    for record in event['Records']:
        sns_message = json.loads(record['body'])['Message']  
        message_body = json.loads(sns_message)

        logger.info(f"✅ Received database request in original format: {message_body}")

        try:
            pr_url = create_github_pr(message_body)
            logger.info(f"🚀 PR created successfully: {pr_url}")
        except Exception as e:
            logger.error(f"❌ Error creating PR: {e}")
            return {
                "statusCode": 500,
                "body": json.dumps(f"Error creating PR: {str(e)}")
            }

    return {
        "statusCode": 200,
        "body": json.dumps("PR created successfully!")
    }