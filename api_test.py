#!/usr/bin/env python3

import splunklib.client as client
from getpass import getpass
import time
import sys

def EstablishConnection(host,port,username,password):
    #
    try:
        #
        service = client.connect(
                                    scheme = 'https',
                                    host = host,
                                    port = port,
                                    username = username,
                                    password = password
                                )
        #
        if(service):
            #
            print(service)
            #
            for app in service.apps:
                #
                print(app.name)
                #
        else:
            #
            return 
            #
    except Exception as e:
        #
        print("[!] Failed to establish a connection: %s " % e)
        #
        sys.exit()

def main():
    #
    print("[*] Splunk Query Script [*]")
    #
    host = input("[+] Enter the URL of the Splunk host-> ")
    #
    port = input("[+] Enter the port for the Splunk instance-> ")
    #
    username = input("[+] Enter your username-> ")
    #
    password = getpass("[+] Enter your password-> ")
    #
    EstablishConnection(host,port,username,password)

if(__name__ == '__main__'):
    #
    main()