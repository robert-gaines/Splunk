#!/usr/bin/env python3

from requests.auth import HTTPBasicAuth
from getpass import getpass
import requests

user = 'robert.gaines'

password = getpass("[+] Password-> ")

response = requests.get('https://splunk.wsu.edu:8000/',auth=(user, password))

print(response.status_code)