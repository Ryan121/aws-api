# aws-api
A test api deployed via terraform to demo CRUD functionality

# API testing
# Send an HTTP POST request without a request body and the lambda function will add a default item to the dynamodb table

curl -X POST '<your http api endpoint>'/movies 

#sample output

{
  "message": "Successfully inserted data!"
}


# Send an HTTP POST request an include a request body in the format below and the lambda function will create a new item in the dynamodb table

curl -X POST '<your http api endpoint>'/movies \
--header 'Content-Type: application/json' \
-d '{"year":1977, "title":"Starwars"}' 

#sample output

{
  "message": "Successfully inserted data!"
}

# For demo-app 

curl -X POST '<your http api endpoint>'/movies \
-d '{"operation": "create", "payload": {"Item": {"id": "5678EFGH", "number": 15}}}'

curl -X POST '<your http api endpoint>'/movies \
-d '{"operation": "update", "payload": {"Item": {"id": "5678EFGH", "number": 19}}}'

curl -X POST '<your http api endpoint>'/movies \
-d '{"operation": "read", "payload": {"Key": {"id": "5678EFGH"}}}'

curl -X POST '<your http api endpoint>'/movies \
-d '{"operation": "delete", "payload": {"Key": {"id": "5678EFGH"}}}'

# Create
curl https://dapl25xqv1.execute-api.us-east-1.amazonaws.com/movies \
--header 'Content-Type: application/json' \
-d '{"operation": "echo", "payload": {"Item": {"year":1950, "title":"Carry On Darling"}}}'

self.table.put_item(
                Item={
                    'year': year,
                    'title': title,
                    'info': {'plot': plot, 'rating': Decimal(str(rating))}})


# Read
curl https://dapl25xqv1.execute-api.us-east-1.amazonaws.com/movies --header 'Content-Type: application/json' -d '{"operation": "read", "payload": {"Key": {"year": 1977, "title": "Starwars"}}}'

# Delete
curl https://dapl25xqv1.execute-api.us-east-1.amazonaws.com/movies --header 'Content-Type: application/json' -d '{"operation": "delete", "payload": {"Key": {"year": 1977, "title": "Starwars"}}}'

# Update

            response = self.table.update_item(
                Key={'year': year, 'title': title},
                UpdateExpression="set info.rating=:r, info.plot=:p",
                ExpressionAttributeValues={
                    ':r': Decimal(str(rating)), ':p': plot},
                ReturnValues="UPDATED_NEW")

            response = self.table.update_item(
                Key={'year': year, 'title': title},
                UpdateExpression="set info.rating = info.rating + :val",
                ExpressionAttributeValues={':val': Decimal(str(rating_change))},
                ReturnValues="UPDATED_NEW")

# Scan and Query

def scan_movies(self, year_range):
        """
        Scans for movies that were released in a range of years.
        Uses a projection expression to return a subset of data for each movie.

        :param year_range: The range of years to retrieve.
        :return: The list of movies released in the specified years.
        """
        movies = []
        scan_kwargs = {
            'FilterExpression': Key('year').between(year_range['first'], year_range['second']),
            'ProjectionExpression': "#yr, title, info.rating",
            'ExpressionAttributeNames': {"#yr": "year"}}
        try:
            done = False
            start_key = None
            while not done:
                if start_key:
                    scan_kwargs['ExclusiveStartKey'] = start_key
                response = self.table.scan(**scan_kwargs)
                movies.extend(response.get('Items', []))
                start_key = response.get('LastEvaluatedKey', None)
                done = start_key is None
        except ClientError as err:
            logger.error(
                "Couldn't scan for movies. Here's why: %s: %s",
                err.response['Error']['Code'], err.response['Error']['Message'])
            raise

        return movies


response = self.table.query(KeyConditionExpression=Key('year').eq(year))