import yaml
import json5
import os
import requests
import json
import glob
import sys
from urllib.parse import quote_plus, unquote
class UpdateLocalisation:

    def __init__(self, config):
        self.access_token = config['access_token']
        self.project_id_android_ios = config['project_id_android_ios']
        self.project_id_web = config['project_id_web']

    def download_locals(self, platform, language, branch='master'):
        """
        Download localization files from the specified platform, language, and branch.
        """
        # Set project_id and directory_path based on platform
        if platform in ['android', 'ios']:
            project_id = self.project_id_android_ios
            directory_path = quote_plus('src/core/i18n/translations/')
            local_directory = '../localisation/mobile/'
        else:
            project_id = self.project_id_web
            branch = 'main' if branch == 'master' else branch
            directory_path = quote_plus(f'public/locales/{language}/')
            local_directory = '../localisation/web/'

        # API call to get repository tree
        url = f'https://gitlab.com/api/v4/projects/{project_id}/repository/tree?ref={branch}&path={directory_path}'
        headers = {'Private-Token': self.access_token}
        response = requests.get(url, headers=headers)

        # Download and save localization files
        if response.status_code == 200:
            for file_info in response.json():
                if file_info.get('type') == 'blob':
                    # Check if filename matches the currently processed language for mobile platforms
                    if platform in ['android', 'ios'] and file_info.get('name') != f'{language}.ts':
                        continue
                    self.download_and_save_file(file_info, branch, local_directory, project_id)
            if platform not in ['android', 'ios']:
                self.combine_web_localization_files(language)
        else:
            print(f'Error listing files in directory: {response.status_code}')


    def download_and_save_file(self, file_info, branch, local_directory, project_id):
        """
        Download and save a localization file based on the given file_info.
        """
        file_path = file_info.get('path')
        filename = file_info.get('name')
        download_url = f'https://gitlab.com/api/v4/projects/{project_id}/repository/files/{quote_plus(file_path)}/raw?ref={branch}'
        download_response = requests.get(download_url, headers={'Private-Token': self.access_token})
        if download_response.status_code == 200:
            filename = unquote(filename)
            script_directory = os.path.dirname(os.path.abspath(__file__))
            local_file_path = os.path.join(script_directory, local_directory, filename)
            with open(local_file_path, 'wb') as f:
                f.write(download_response.content)
                print(f'File {filename} downloaded successfully.')
        else:
            print(f'Error downloading file: {download_response.status_code}')

    def combine_web_localization_files(self, language):
        """
        Combine downloaded web localization JSON files into a single file.
        """
        script_path = os.path.dirname(os.path.abspath(__file__))
        directory_path = os.path.join(script_path, '..', 'localisation', 'web')
        combined_data = {}
        for filename in os.listdir(directory_path):
            if filename.endswith('.json'):
                file_path = os.path.join(directory_path, filename)
                with open(file_path, 'r') as f:
                    file_data = json.load(f)
                    combined_data.update(file_data)
                os.remove(file_path)
        output_file = os.path.join(directory_path, language + '.ts')
        with open(output_file, 'w') as f:
            json.dump(combined_data, f)

    def convert_ts_to_yaml(self, platform, language):
        """
        Convert downloaded TypeScript localization files to YAML files.
        """
        # Add platform prefix based on the platform
        if platform in ['android', 'ios', 'mobile']:
            platform_prefix = 'mobile'
            platform_directory = 'mobile'
        else:
            platform_prefix = 'web'
            platform_directory = 'web'

        # Specify the directory where the files are located
        dir_path = f'resources/localisation/{platform_directory}/'
        abs_dir_path = os.path.join(os.getcwd(), dir_path)

        # Load the TypeScript data from file and process it
        typescript_data = self.load_file(os.path.join(abs_dir_path, f'{language}.ts'))
        processed_data = self.process_typescript_data(typescript_data)

        # Convert the processed TypeScript data to a Python object
        ts_data = processed_data.replace("export default {", "{")
        py_obj = json5.loads(ts_data)

        # Add platform prefix to the YAML content
        yaml_data = {platform_prefix: py_obj}

        # Write the Python object to a YAML file
        output_file_path = os.path.join(abs_dir_path, f'{language}.yaml')
        self.write_yaml_file(yaml_data, output_file_path)

        # Cleanup and delete the TypeScript file
        self.remove_files(os.path.join(abs_dir_path, f'{language}.ts'))

    @staticmethod
    def load_file(file_path):
        with open(file_path) as f:
            return f.read()

    @staticmethod
    def process_typescript_data(typescript_data):
        while True:
            lines = typescript_data.split('\n')
            new_lines = []
            i = 0
            while i < len(lines):
                line = lines[i]
                if line.rstrip().endswith('+'):
                    new_line = line.rstrip()[:-2].rstrip("'") + lines[i+1].lstrip().lstrip("'")
                    new_lines.append(new_line)
                    i += 2
                else:
                    new_lines.append(line)
                    i += 1
            typescript_data = '\n'.join(new_lines).replace("{{ ", "{{").replace(" }}", "}}")
            if not any(line.rstrip().endswith('+') for line in new_lines):
                break
        return typescript_data

    @staticmethod
    def write_yaml_file(py_obj, output_file_path):
        class NoNewlineDumper(yaml.Dumper):
            def represent_scalar(self, tag, value, style=None):
                if '\n' in value:
                    style = '"'
                return super().represent_scalar(tag, value, style)

        with open(output_file_path, 'w') as file:
            yaml.dump(py_obj, file, Dumper=NoNewlineDumper, allow_unicode=True,
                      default_flow_style=False, width=float("inf"), indent=4, sort_keys=False)

    @staticmethod
    def remove_files(file_pattern):
        files = glob.glob(file_pattern)
        for file in files:
            os.remove(file)


if __name__ == '__main__':
    script_directory = os.path.dirname(os.path.abspath(__file__))
    config_file_path = os.path.join(script_directory, '..', 'settings', 'gitlab.yaml')
    with open(config_file_path, 'r') as config_file:
        config = yaml.safe_load(config_file)
    updater = UpdateLocalisation(config)
    platform = sys.argv[1].lower()
    try:
        branch = sys.argv[2].lower()
    except:
        branch = 'master'

    for language in ['en', 'th']:
        updater.download_locals(platform, language, branch)
        updater.convert_ts_to_yaml(platform, language)