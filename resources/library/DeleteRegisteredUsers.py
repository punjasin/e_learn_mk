import psycopg2
import requests
import boto3
from robot.libraries.BuiltIn import BuiltIn

class DeleteRegisteredUsers():
    def delete_user_aws_cognito(self, aws_cognito, phone_no_to_be_deleted):
        try:
            # Create a new Boto3 session
            response = self.get_available_number(aws_cognito, phone_no_to_be_deleted)
            session = boto3.Session(profile_name=aws_cognito["profile_name"])
            cognito = session.client('cognito-idp')
            
            if response['Users']:
                username_to_delete = response['Users'][0]['Username']
                response = cognito.admin_delete_user(
                    UserPoolId=aws_cognito["UserPoolId"],
                    Username=username_to_delete
                )
                print("Username for the user to be deleted: ", username_to_delete)
                print("Deleted from Aws Cognito : ", response['ResponseMetadata']['HTTPStatusCode'] == 200)
            else:
                print("Aws_Cognito: No users found with the specified email or phone number.")
        except Exception as e:
            print(f"Error occurred while deleting user from AWS Cognito: {e}")
            
    def get_available_number(self, aws_cognito, phone_no_to_be_deleted):
            session = boto3.Session(profile_name=aws_cognito["profile_name"])
            cognito = session.client('cognito-idp')
            
            response = cognito.list_users(
                UserPoolId=aws_cognito["UserPoolId"],
                Filter="phone_number=\"{}\"".format(phone_no_to_be_deleted)
            )
            BuiltIn().log(response)
            return    response

    # Getting Shopify_Id from DB using Phone number
    def fetching_shopifyId_WithPhoneNumber(self, shopify_api, phone_no_to_be_deleted):
        try:
            # Define the API endpoint and query parameters
            endpoint = shopify_api["endpoint"]
            params = {'query': phone_no_to_be_deleted}

            # Set up the authentication headers
            headers = {
                'Content-Type': 'application/json',
                'X-Shopify-Access-Token': shopify_api["shopify_token"]
            }

            # Make the API call
            response = requests.get(endpoint, headers=headers, params=params)

            # Parse the response JSON and retrieve the customer ID
            data = response.json()
            customer_id = data['customers'][0]['id']
            if customer_id:
                return customer_id
            else:
                print("Shopify: No users found with the specified phone number.")
                return None
        except Exception as e:
            print(f"Error occurred while fetching Shopify ID: {e}")
            return None

    # Deleting From Shopify
    def delete_user_shopify(self, shopify_api, shopify_id):
        try:
            if shopify_id is not None:
                shopify_url = shopify_api["url_user"].replace("shopify_id",shopify_id)
                url = f''+shopify_url
                response = requests.delete(url)
                
                if response.status_code == 200:
                    print("Shopify user deleted: " + shopify_id)
                else:
                    print("Error occurred while deleting user from Shopify")
            else:
                print("Error: shopify_id is None")
        except Exception as e:
            print(f"Error occurred while deleting user from Shopify: {e}")


    # Deleting from DB
    def delete_user_DB(self, db_user, phone_no_to_be_deleted):
        # Establishing the connection
        try:
            conn = psycopg2.connect(
                database=db_user["database"],
                user=db_user["user"],
                password=db_user["password"],
                host=db_user["host"],
                port=db_user["port"]
            )
        except psycopg2.Error as e:
            print(f"DB Error: {e}")
            return

        try:
            # Fetch the user with the provided phone number
            with conn.cursor() as cur:
                cur.execute("SELECT * FROM users WHERE mobile = %s", (phone_no_to_be_deleted,))
                user = cur.fetchone()

            # If the user exists, delete them from the database
            if user:
                with conn.cursor() as cur:
                    cur.execute("DELETE FROM users WHERE mobile = %s", (phone_no_to_be_deleted,))
                    conn.commit()
                    print(f"User with phone number {phone_no_to_be_deleted} deleted successfully")
            else:
                print(f"No user with phone number {phone_no_to_be_deleted} found in the database")
        except psycopg2.Error as e:
            print(f"DB Error: {e}")
        finally:
            # Closing the connection
            conn.close()
