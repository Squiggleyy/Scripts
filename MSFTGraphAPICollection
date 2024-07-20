import requests
import logging
import json_log_formatter

# Configuration for OAuth2
tenant_id = 'your_tenant_id_here'
client_id = 'your_client_id_here'
client_secret = 'your_client_secret_here'
scope = 'https://api.securitycenter.microsoft.com/.default'
token_url = f'https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token'

# Setup JSON formatter for logging
formatter = json_log_formatter.JSONFormatter()
json_handler = logging.FileHandler(filename='uabMicrosoftDFE.log')
json_handler.setFormatter(formatter)

logger = logging.getLogger('json_logger')
logger.addHandler(json_handler)
logger.setLevel(logging.INFO)

# Defines a supporting function that grabs the bearer token
def get_access_token():
    print("Requesting access token...")
    payload = {
        'client_id': client_id,
        'scope': scope,
        'client_secret': client_secret,
        'grant_type': 'client_credentials'
    }
    response = requests.post(token_url, data=payload)
    response.raise_for_status()
    token_info = response.json()
    print("Access token obtained successfully.")
    return token_info['access_token']

# URL for the API request
api_url = 'https://api-eu.securitycenter.microsoft.com/api/alerts?$top=10&$orderby=alertCreationTime desc'

def fetch_and_log_alerts():
    try:
        # Obtain access token
        access_token = get_access_token()

        # Headers for the request including the bearer token
        headers = {
            'Authorization': f'Bearer {access_token}'
        }

        print("Making API request...")
        # Make the GET request to the API with headers
        response = requests.get(api_url, headers=headers)
        response.raise_for_status()
        blob = response.json()
        print("API request successful.")

        # Log each entry in the response
        for entry in blob['value']:
            logger.info('Microsoft Defender Endpoint alert', extra=entry)
        print(f"Logged {len(blob['value'])} alerts.")

    except requests.exceptions.HTTPError as err:
        logger.error(f'HTTP error occurred: {err}')
        print(f'HTTP error occurred: {err}')
    except Exception as err:
        logger.error(f'Other error occurred: {err}')
        print(f'Other error occurred: {err}')

# Run the fetch and log function
print("Starting the script...")
fetch_and_log_alerts()
print("Script finished.")
