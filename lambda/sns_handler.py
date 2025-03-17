import json
import os
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

sns_client = boto3.client('sns')

def lambda_handler(event, context):
    try:
        # לקרוא את גוף הבקשה שהגיע מה-API Gateway
        database_request = json.loads(event['body'])

        response = sns_client.publish(
            TopicArn=os.environ['TOPIC_ARN'],
            Message=json.dumps(database_request)
        )

        logger.info(f"✅ Message sent to SNS: {database_request}")

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Message sent successfully!"})
        }

    except Exception as e:
        logger.error(f"❌ Error processing request: {e}")
        return {
            "statusCode": 400,
            "body": json.dumps({"error": str(e)})
        }
