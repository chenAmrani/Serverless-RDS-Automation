import json
import boto3
import logging
import time

logger = logging.getLogger()
logger.setLevel(logging.INFO)

rds_client = boto3.client('rds')

def lambda_handler(event, context):
    for record in event['Records']:
        sns_message = json.loads(record['body'])['Message']  
        message_body = json.loads(sns_message)

        logger.info(f"✅ Received database request in original format: {message_body}")

       
        try:
            response = rds_client.create_db_instance(
                DBName=message_body['databaseName'],
                DBInstanceIdentifier=message_body['databaseName'],
                Engine=message_body['engine'].lower(),
                DBInstanceClass='db.t3.micro',
                MasterUsername='admin',
                MasterUserPassword='YourSecurePassword123!',
                AllocatedStorage=20  
            )

            logger.info(f"🚀 RDS Instance created successfully: {response}")
        except Exception as e:
            logger.error(f"❌ Error creating RDS instance: {e}")
            return {
                "statusCode": 500,
                "body": json.dumps(f"Error creating RDS instance: {str(e)}")
            }

    return {
        "statusCode": 200,
        "body": json.dumps("Messages processed successfully")
    }
