import subprocess
import time

from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

import report_portal_settings as variable

def listen_aws_sso_login():
    cmd = f"aws sso login --profile {variable.aws_profile} --no-browser"
    
    # Use Popen to run the command and capture the output
    process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    
    # Flags to indicate that we have found the target line and retrieved the code
    found_target_line = False
    retrieved_code = False
    while process.poll() is None:
        # Read line by line to get real-time output
        output = process.stdout.readline().decode()

        # If we have found the target line and t his is the first non-empty line after it, then print it and stop
        if found_target_line and not retrieved_code and output.strip():
            with open('sso_url.txt', 'w') as f:
                f.write(output.strip() + '\n')
            retrieved_code = True
            return

        # If this is the target line, then set the flag
        if "Alternatively," in output:
            found_target_line = True
        else:
            # If there's no output, wait a bit before trying again to prevent high CPU usage
            time.sleep(0.1)
    
    # The process has ended, but there may still be output to read
    remaining_output = process.stdout.read().decode()
    if remaining_output and found_target_line and not retrieved_code:
        with open('sso_url.txt', 'w') as f:
            f.write(remaining_output.strip() + '\n')

    # return the exit code of the process
    return process.poll()

def allow_sso():
    with open('sso_url.txt', "r") as file:
        url = file.read()
    options = Options()
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
    driver.get(url)
    # fill in username and password
    WebDriverWait(driver, 20).until(EC.element_to_be_clickable((By.XPATH, "//*[@id='okta-signin-username']"))).send_keys(variable.okta_username)
    WebDriverWait(driver, 20).until(EC.element_to_be_clickable((By.XPATH, "//*[@id='okta-signin-password']"))).send_keys(variable.okta_password)
    WebDriverWait(driver, 20).until(EC.element_to_be_clickable((By.XPATH, "//*[@id='okta-signin-submit']"))).click()
    WebDriverWait(driver, 20).until(EC.element_to_be_clickable((By.XPATH, "//button[@id='cli_login_button']"))).click()
    driver.quit()
    print('aws sso login successfully')

if __name__ == '__main__':
    listen_aws_sso_login()
    allow_sso()