import boto3
import json
import logging
import os
# define the DynamoDB table that Lambda will connect to
# tableName = "lambda-apigateway"

# create the DynamoDB resource 
# dynamo = boto3.resource('dynamodb').Table(tableName)
# dynamo = boto3.client('dynamodb')

logger = logging.getLogger()
logger.setLevel(logging.INFO)

print('Loading function')

def lambda_handler(event, context):
    '''Provide an event that contains the following keys:

      - operation: one of the operations in the operations dict below
      - payload: a JSON object containing parameters to pass to the 
                 operation being performed
    '''

    # tableName = "Movies"
    dynamo_table_name = os.environ.get('DDB_TABLE')
    dynamo = boto3.resource('dynamodb').Table(dynamo_table_name)
    logger.info(f"Table name: { dynamo_table_name }, Table object: { dynamo } ")

    # define the functions used to perform the CRUD operations
    def ddb_create(x):
        dynamo.put_item(**x)
        output = f"The item { x } was successfully created and saved!"
        return output

    def ddb_read(x):
        dynamo.get_item(**x)
        output = f"The item { x } was retrieved!"
        return output

    def ddb_update(x):
        dynamo.update_item(**x)
        output = f"The item { x } was successfully updated!"
        return output
        
    def ddb_delete(x):
        dynamo.delete_item(**x)
        output = f"The item { x } was successfully deleted!"
        return output

    def echo(x):
        return x

    # logger.info(f"Initiating lambda...")

    try:
        
        item = json.loads(event["body"])
        logger.info(f"The body of the request is: { item }")

        operation = item['operation']
        payload = item['payload']
        logger.info(f"The operation of the request api call is: { operation }")
        logger.info(f"The payload of the request api call is: { payload }")
        
        operations = {
            'create': ddb_create,
            'read': ddb_read,
            'update': ddb_update,
            'delete': ddb_delete,
            'echo': echo,
        }

        if operation in operations:
            logger.info(f"The dynamodb operation to perform is: { operations[operation] }")
            output = operations[operation](payload)
            # dynamo.put_item(Item={"year": payload["year"], "title": str(payload["title"])})

            logger.info(f" { item['operation'] } operation successfully ran" )
            return {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                },
                "body": json.dumps({"message": output})
            }
        else:
            raise ValueError('Unrecognized operation "{}"'.format(operation))

    except Exception as e:
        logger.error(e)
        return {
            'statusCode': 501,
            'body': '{"status":"Function error!"}'
        }
