import requests
import json
import os
import report_portal_settings as variables

base_url = 'https://api.qase.io/v1'

headers = {
    'Content-Type': 'application/json',
    'Token': variables.qase_api_token
}

# Define project-specific variables
project_code = 'MAKNET'

def update_result(run_id, case_id, status, elasped_time, message):
    url = f'{base_url}/result/{project_code}/{run_id}'
    result_data = {
        "status": status.lower(),
        "case_id": case_id,
        "time_ms": elasped_time,
        "comment": message
    }

    response = requests.post(url, headers=headers, json=result_data)
    return response.json()

def delete_result(project_code, run_id, case_id):
    url = f'{base_url}/result/{project_code}/{run_id}/{case_id}'
    response = requests.delete(url, headers=headers)
    return response

def convert_status(status):
    if status == 'PASS':
        return 'passed'
    elif status == 'FAIL':
        return 'failed'
    elif status == 'SKIP':
        return 'skipped'
    else:
        return 

def main(test_case_id=None, status=None, elasped_time=None, message=None):
    # Check if test_case_id and run_id are provided as command-line arguments
    print(test_case_id, status, elasped_time)
    run_id = os.getenv('QASE_RUN_ID') if os.getenv('QASE_RUN_ID') else None
    if test_case_id is not None and run_id is not None:
        test_case_id = int(test_case_id)

        # Define updated data for an existing result
        if status is not None:
            status = convert_status(status)
            if status.lower() in ["in_progress", "failed", "passed", "blocked", "skipped"]:
                # Update the existing result with the provided case_id and status
                updated_result_response = update_result(run_id, test_case_id, status, elasped_time, message)
                print(updated_result_response)
            else:
                print("Invalid status. Available options: in_progress, failed, passed, blocked, skipped")
        else:
            print("Insufficient arguments for update data. Skipping further result update.")