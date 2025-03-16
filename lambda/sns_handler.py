import boto3 
import os
import json

sns_client = boto3.client('sns')

def lambda_handler(event, context):
    message = "New RDS Cluster Requested"
    response = sns_client.publish(
        TopicArn=os.environ['TOPIC_ARN'],
        Message=message
    )
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Message sent successfully!"})
    }
