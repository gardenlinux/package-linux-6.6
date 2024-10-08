from urllib.request import urlopen
import json
import re

current_lts = '6.6'
script_content = ""

def update_version(file_path, new_version):
    # Define the regex pattern to match the version_orig variable
    pattern = re.compile(r'(version_orig=)([\d\.]+)')
    
    with open(file_path, 'r') as file:
        script_content = file.read()
    
    # Search for the pattern and replace the version_orig value
    updated_content = pattern.sub(r'\1{}'.format(re.escape(new_version)), script_content)
    
    with open(file_path, 'w') as file:
        file.write(updated_content)

with urlopen("https://www.kernel.org/releases.json") as response:
    releases = json.loads(response.read().decode())["releases"]
    latest_current_lts = [
        r['version'] for r in releases if r["moniker"] == "longterm" and r["iseol"] == False and r['version'].startswith(current_lts)
    ]
    assert len(latest_current_lts) == 1
    print(latest_current_lts[0])
    new_version=latest_current_lts[0]

    update_version('prepare_source', new_version)
