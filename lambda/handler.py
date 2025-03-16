import json

def lambda_handler(event, context):
    print("Lambda function triggered successfully!")
    return {
        "statusCode": 200,
        "body": json.dumps({"message": "Hello World!"})
    }
