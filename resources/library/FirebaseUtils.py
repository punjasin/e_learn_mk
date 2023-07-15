import os
import sys
import requests
from firebase_admin import credentials
from robot.api import logger

project_number = os.getenv('FIREBASE_PROJECT')
username = os.getenv('BROWSERSTACK_USERNAME')
bs_access_token = os.getenv('BROWSERSTACK_TOKEN')

app_android = {
    'Maknet Debug':f'1:{project_number}:android:9b5a2eac16e6ae101444ed',
    'Maknet Production':f'1:{project_number}:android:a6274262914c16a11444ed',
    'Maknet QA':f'1:{project_number}:android:8ab8327f3196224c1444ed',
}

app_ios = {
    'Maknet Debug':f'1:{project_number}:ios:ee47a5f05456e70f1444ed',
    'Maknet Production':f'1:{project_number}:ios:da69e36e409c12fb1444ed',
    'Maknet QA':f'1:{project_number}:ios:273876b7b6a650cc1444ed',
    'Makro PRO Debug':f'1:{project_number}:ios:26884403c677a1a11444ed',
    'Makro PRO QA':f'1:{project_number}:ios:b6f4c7885c5a2dd01444ed',
}

class FirebaseUtils:
    def platform_init(self, platform):
        if platform == 'android':
            suffix = 'apk'
            app = app_android
        elif platform == 'ios':
            suffix = 'ipa'
            app = app_ios
        else:
            print(f'Not support {platform}')
            sys.exit(1)
        return suffix, app

    def get_google_access_token(self):
        return credentials.ApplicationDefault().get_access_token().access_token

    def list_projects(self, app_id, build_number):
        accessToken = self.get_google_access_token()
        uri = f"https://firebaseappdistribution.googleapis.com/v1/projects/{project_number}/apps/{app_id}/releases?pageSize=100"
        headers = {
            'Authorization': 'Bearer ' + accessToken,
        }
        response = requests.get(uri, headers=headers)
        matching_objs = [x for x in response.json()['releases']
                        if x['buildVersion'] == build_number]
        if len(matching_objs):
            return matching_objs[0]['buildVersion'], matching_objs[0]['binaryDownloadUri']
        else:
            print('Build number does not exists!')
            sys.exit(1)

    def download_app_file(self, name, uri, suffix):
        response = requests.get(uri, stream=True)
        with open(f'resources/data/{name}.{suffix}', 'wb') as app_file:
            for chunk in response.iter_content(chunk_size=8192):
                app_file.write(chunk)
        print(f'File downloaded and saved to resources/data/{name}.{suffix}')

    def upload_app_file(self, filename, suffix):
        files = {
            'file': open(f'resources/data/{filename}.{suffix}', 'rb'),
        }
        response = requests.post(
            'https://api-cloud.browserstack.com/app-automate/upload',
            files=files,
            auth=(username, bs_access_token),
        )
        print('Response app_url', response.json()['app_url'])
        return response.json()['app_url']

    def delete_app(self, buildVersion, suffix):
        if os.path.exists(f"resources/data/{buildVersion}.{suffix}"):
            os.remove(f"resources/data/{buildVersion}.{suffix}")
            print(f'Remove apk resources/data/{buildVersion}.{suffix}')
        else:
            print("The file does not exist")
            sys.exit(1)

    def delete_app_on_browserstack(self, app_url):
        app=app_url[5:]
        response = requests.delete(
            f'https://api-cloud.browserstack.com/app-automate/app/delete/{app}',
            auth=(username, bs_access_token)
        )
        logger.console(response.json())
        print(response.json())

if __name__ == "__main__":
    f = FirebaseUtils()
    if len(sys.argv) == 2:
        print("app_url", sys.argv[1])
        f.delete_app_on_browserstack(sys.argv[1])
    else:
        platform = os.getenv('PLATFORM')
        buildNumber = os.getenv('BUILD_NUMBER')
        suffix, app = f.platform_init(platform)
        firebase_app = os.getenv('FIREBASE_ENV_APP')
        app_id = app[firebase_app]
        buildVersion, buildUrl = f.list_projects(app_id, buildNumber)
        f.download_app_file(buildVersion, buildUrl, suffix)
        app_url = f.upload_app_file(buildVersion, suffix)
        print(f'BROWSERSTACK_LINK {app_url}')


