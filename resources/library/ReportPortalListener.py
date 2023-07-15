import logging
import os
import requests
import json 
import datetime
import sys
import base64
import re
import qase
import report_portal_settings as variablefiles
from robotframework_reportportal import logger
from robotframework_reportportal.listener import listener
from robotframework_reportportal.model import Suite
from robotframework_reportportal.static import MAIN_SUITE_ID
from reportportal_client import RPLogger, RPLogHandler
from robot.libraries.BuiltIn import BuiltIn

logging.setLoggerClass(RPLogger)
rp_logger = logging.getLogger(__name__)
rp_logger.setLevel(logging.DEBUG)
rp_logger.addHandler(RPLogHandler())

class ReportPortalListener(listener):
    def __init__(self,):
        self.img_path = None
        listener.__init__(self)
    
    def get_launch_uuid(self, LAUNCH_UUID=None):
        current_datetime = datetime.datetime.now()
        timestamp = int(current_datetime.timestamp() * 1000)

        headers = {
            'Content-Type': 'application/json',
            'Authorization': f'Bearer {variablefiles.RP_UUID}',
        }
        data = {
            'name': variablefiles.RP_LAUNCH,
            'description': f'{os.getenv("PLATFORM").capitalize()} [{os.getenv("LANGUAGE").upper()}]',
            'startTime': str(timestamp),
            'mode': "DEFAULT",
            'attributes': [
                {
                    'key': 'Platform',
                    'value': os.getenv("PLATFORM").capitalize()
                },
                {
                    'key': 'Language',
                    'value': os.getenv("LANGUAGE").upper()
                },
                {
                    'key': 'Tags',
                    'value': os.getenv("TESTTAGS")
                }
            ]
        }
        if os.getenv("BUILD_NUMBER") is not None and os.getenv("BUILD_NUMBER") != '' :
            data['attributes'].append(
                {   
                    'key': 'Build Number',
                    'value': os.getenv("BUILD_NUMBER")
                }
            )
        if LAUNCH_UUID is not None:
            data['uuid'] = LAUNCH_UUID
            data['rerun'] = True
            data['rerunOf'] = LAUNCH_UUID


        response = requests.post(
            f'{variablefiles.RP_ENDPOINT}/api/v1/{variablefiles.RP_PROJECT}/launch',
            headers=headers,
            data=json.dumps(data),
        )
        RP_LAUNCH_UUID =  response.json()['id']
        print(RP_LAUNCH_UUID)

    def start_suite(self, name, attributes, ts=None):
        if attributes['id'] == MAIN_SUITE_ID:
            self.start_launch(attributes, ts)
            if self.variables.pabot_used:
                name += '.{0}'.format(self.variables.pabot_pool_id)
            logger.debug(
                'ReportPortal - Create global Suite: {0}'
                .format(attributes))
            suite = Suite(name, attributes)
            self._items.append(suite)
        else:
            logger.debug('ReportPortal - Start Suite: {0}'.format(attributes))
            suite = Suite(name, attributes)
            suite.rp_parent_item_id = self.parent_id
            suite.doc = suite.source
            suite.rp_item_id = self.service.start_suite(suite=suite, ts=ts)
            self._items.append(suite)

    def end_keyword(self, keyword,  result):
        if result['kwname'] == 'Capture Page Screenshot':
            variables = BuiltIn().get_variables()
            self.img_path = variables['${IMG_PATH}']
            print(self.img_path)
        listener.end_keyword(self, keyword,  result)

    def end_test(self, test, result):
        testcase_id = extract_number_testcase(result['longname'])
        qase.main(testcase_id, result['status'], result['elapsedtime'], result['message'])
        if result['status'] == 'FAIL' and self.img_path is not None:
            with open(self.img_path, "rb") as image_file:
                image_data = image_file.read()
                rp_logger.error("error screenshot",
                    attachment={"name": os.path.basename(self.img_path),
                                "data": image_data,
                                "mime": "image/png"})
        listener.end_test(self, test, result)

def extract_number_testcase(str):
    match = re.search(r'MAKNET-(\d+)', str)
    return match.group(1) if match else None

def get_report_auth():
    client_id = "ui"
    client_secret = "uiman"
    # Authenticate to obtain an access token
    auth_url = f"{variablefiles.RP_ENDPOINT}/uat/sso/oauth/token"
    auth_payload = {
        "grant_type": "password",
        "username": variablefiles.reportportal_username,
        "password": variablefiles.reportportal_password
    }
    basic_auth_string = base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()
    auth_headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {basic_auth_string}"
    }
    auth_response = requests.post(auth_url, data=auth_payload, headers=auth_headers)

    if auth_response.status_code != 200:
        print("Authentication failed. Unable to obtain access token.")
        print("Response content:", auth_response.content)
        return
    
    access_token = auth_response.json().get("access_token")
    return access_token

def get_report_data(report_uuid, access_token):
    # Construct the API URL using the ReportPortal base URL and launch UUID
    api_url = f"{variablefiles.RP_ENDPOINT}/api/v1/{variablefiles.RP_PROJECT}/launch/{report_uuid}"
    
    # Set the headers for the API request with the access token
    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-Type": "application/json"
    }
    
    # Fetch the report data from ReportPortal
    response = requests.get(api_url, headers=headers)
    report_data = response.json()
    return report_data

def post_report_to_slack(report_uuid, rerun=False):

    temp_filename = "logs/temp_notification.json"

    access_token = get_report_auth()
    report_data = get_report_data(report_uuid, access_token)

    if not rerun:
        write_temp_message(report_data, temp_filename)
        defects = report_data['statistics']['defects']
        # Format the defects
        defects_formatted = '\n\t\t'.join([f"{key}: {value['total']}" for key, value in defects.items()])
    else:
        old_report_data = read_temp_message(temp_filename)
        defects_formatted = new_defects_message(old_report_data, report_data)

    launch_name = report_data['name']
    description = report_data['description']
    # Extract the relevant information from the report

    start_time = report_data['startTime']
    last_modified = report_data['lastModified']

    # Calculate duration and convert it to "hours:minutes" format
    duration_in_seconds = (last_modified - start_time) / 1000
    hours = duration_in_seconds // 3600
    minutes = (duration_in_seconds % 3600) // 60
    duration = f"{int(hours)}h:{int(minutes)}m"

    pass_count =  report_data['statistics']['executions']['passed'] if 'passed' in report_data['statistics']['executions'] else '0'
    fail_count =  report_data['statistics']['executions']['failed'] if 'failed' in report_data['statistics']['executions'] else '0'
    report_ui = f"{variablefiles.RP_ENDPOINT}/ui/#makro_pro/launches/all/{report_data['id']}"
    
    # Extract tags
    tags = ', '.join([f"{attr['key']}:{attr['value']}" if attr['key'] else attr['value'] for attr in report_data['attributes']])
    
    # Create the message to send to Slack
    message = f"*Report for {launch_name}*\nDescription: {description}\nDuration: {duration}\nPass: {pass_count}\nFail: {fail_count}\n\t\t{defects_formatted}\n{tags}\n<{report_ui}|(Report)>"
    
    # Prepare the payload for Slack
    payload = {
        "text": message
    }
    
    # Send the payload to Slack
    response = requests.post(variablefiles.slack_webhook_url, data=json.dumps(payload))
    print(json.dumps(payload, indent=1))
    
    # Check the response from Slack
    if response.status_code == 200:
        print("Report posted to Slack successfully!")
    else:
        print("Failed to post report to Slack.")

def get_projects(username, token, base_url):
    # Construct the API URL
    api_url = f"{base_url}/api/v1/user/{username}/project"

    # Set the headers for the API request with the access token
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    
    # Fetch the project data from ReportPortal
    response = requests.get(api_url, headers=headers)
    projects_data = response.json()
    
    # Print out the list of projects and user's role in each
    print(f"Projects for user {username}:")
    for project in projects_data:
        print(f"{project['projectName']}: {project['assignedRoles'][username]}")

def write_temp_message(report_data, filename):
    with open(filename, 'w') as file:
        json_obj = json.dumps(report_data, indent=4)
        file.write(json_obj)

def read_temp_message(filename):
    with open(filename, 'r') as file:
        data = json.load(file)
    return data

def new_defects_message(old_report, new_report):
    defects_formatted = ""
    old_defects = old_report['statistics']['defects']
    new_defects = new_report['statistics']['defects']
    for key, value in old_defects.items():
        if key not in new_defects:
            defects_formatted +=f"{key}: 0 (-{value['total']} rerun)\n\t\t"

    for key, value in new_defects.items():
        if key in old_defects:
            difference = value['total'] - old_defects[key]['total']
            defects_formatted +=f"{key}: {value['total']} ({difference} rerun)\n\t\t"
        else:
            defects_formatted +=f"{key}: {value['total']} (+{value['total']} rerun)\n\t\t"

    return defects_formatted

if __name__ == '__main__':
    if sys.argv[1] == 'create_launch':
        rp = ReportPortalListener()
        if len(sys.argv) < 3:
            rp.get_launch_uuid()
        else:
            rp.get_launch_uuid(sys.argv[2])
    elif sys.argv[1] == 'slack_notification':
        if len(sys.argv) <= 3 :
            post_report_to_slack(sys.argv[2])
        else:
            post_report_to_slack(sys.argv[2], rerun=True)