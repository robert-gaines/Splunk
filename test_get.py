#!/usr/bin/env python3

from requests.auth import HTTPBasicAuth
from getpass import getpass
import requests

user = ''

password = getpass("[+] Password-> ")

response = requests.get('https://<url>:8000/',auth=(user, password))

print(response.status_code)
