#!/bin/bash python

import boto3
import botocore.exceptions
import yaml
import json
from tabulate import tabulate



ec2 = boto3.client('ec2')

try:
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'instance-state-name',
                'Values': [
                    'running',
                ]
            },
        ]
     )
except botocore.exceptions.ClientError as error:
    raise error

instance_num=len(response.get('Reservations')[0].get('Instances'))

for  instance in response.get('Reservations')[0].get('Instances'):
    instanceId=instance.get('InstanceId')
    publicIp=instance.get('NetworkInterfaces')[0].get('Association').get('PublicIp')
    privateIp=instance.get('NetworkInterfaces')[0].get('PrivateIpAddress')
    tags=instance.get('Tags')
    print("Instance ID: " + str(instanceId), "\nPublic IP: " + str(publicIp), "\nPrivate IP: " + str(privateIp), "\nTags: " + str(tags))

