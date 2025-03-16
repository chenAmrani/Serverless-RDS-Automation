import boto3
import os
import json

sns_client = boto3.client('sns')

def lambda_handler(event, context):
    print("✅ Received request to publish message to SNS")
    
    message = event.get('request', 'Default SNS Message')
    response = sns_client.publish(
        TopicArn=os.environ['TOPIC_ARN'],
        Message=message
    )
    
    print(f"📩 SNS Response: {response}")
    
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Message sent successfully!"})
    }
