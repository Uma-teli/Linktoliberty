import sys
import json

WORKSPACE = "/var/jenkins/workspace/WMLzCobolPipeline"
with open(WORKSPACE +'/extracted_data.json', 'r') as f:
    data = json.load(f)

print(data[sys.argv[1]])