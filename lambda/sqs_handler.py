import json

def lambda_handler(event, context):
    print("✅ Lambda triggered by SQS!")
    
    for record in event.get('Records', []):
        message_body = record['body']
        print(f"📥 Received message from SQS: {message_body}")
    
    return {
        "statusCode": 200,
        "body": json.dumps("Messages processed successfully")
    }
