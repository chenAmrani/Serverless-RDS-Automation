import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    for record in event['Records']:
        message_body = json.loads(record['body'])   
        logger.info(f"✅ Received database request in original format: {message_body}")

    return {
        "statusCode": 200,
        "body": json.dumps("Messages processed successfully")
    }
