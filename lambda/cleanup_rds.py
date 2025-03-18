import boto3
import logging
import os
from datetime import datetime, timedelta

logger = logging.getLogger()
logger.setLevel(logging.INFO)

rds_client = boto3.client('rds')

RETENTION_PERIOD = int(os.getenv('RETENTION_PERIOD', 3))

def lambda_handler(event, context):
    try:
        max_creation_date = datetime.now() - timedelta(hours=RETENTION_PERIOD)

        db_instances = rds_client.describe_db_instances()

        for instance in db_instances['DBInstances']:
            instance_id = instance['DBInstanceIdentifier']
            creation_date = instance['InstanceCreateTime'].replace(tzinfo=None)

            tags_response = rds_client.list_tags_for_resource(
                ResourceName=instance['DBInstanceArn']
            )
            tags = tags_response['TagList']
            environment = next(
                (tag['Value'] for tag in tags if tag['Key'] == 'Environment'), 
                'Unknown'
            )

            if (
                environment in ['Dev', 'Test'] or 
                (environment == 'Prod' and any(
                    tag['Key'] == 'AutoDelete' and tag['Value'] == 'True' 
                    for tag in tags
                ))
            ):
                if creation_date < max_creation_date:
                    logger.info(f"🗑️ Deleting RDS instance: {instance_id} (Environment: {environment})")
                    rds_client.delete_db_instance(
                        DBInstanceIdentifier=instance_id,
                        SkipFinalSnapshot=True,
                        DeleteAutomatedBackups=True
                    )
                    logger.info(f"✅ Successfully started deletion for: {instance_id}")
                else:
                    logger.info(f"⏳ Skipping deletion for {instance_id} (Created on {creation_date})")
            else:
                logger.info(f"🚫 Skipping deletion for {instance_id} (Environment: {environment})")

        return {"status": "Success", "message": "Cleanup process completed."}

    except Exception as e:
        logger.error(f"❌ Error during cleanup: {str(e)}")
        return {"status": "Error", "message": str(e)}
