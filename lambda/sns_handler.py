import json
import os
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

sns_client = boto3.client('sns')

def lambda_handler(event, context):
    database_request = {
        "databaseName": "exampleDB",
        "engine": "MySQL",
        "environment": "Dev"
    }

    response = sns_client.publish(
        TopicArn=os.environ['TOPIC_ARN'],
        Message=json.dumps(database_request)  
    )

    logger.info(f"✅ Message sent to SNS: {database_request}")

    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Message sent successfully!"})
    }
