#!/bin/bash

test=$(aws ec2 describe-instances --filter Name=instance-state-name,Values=running --region us-east-1 --output json)
if [ -z "$test" ] ; then
  echo unable to pull running instance
  exit 1
fi

instances=$(aws ec2 describe-instances --filter Name=instance-state-name,Values=running --region us-east-1 --output json | jq -r .Reservations[].Instances[].InstanceId)
eip=$(aws ec2 describe-instances --filter Name=instance-state-name,Values=running --region us-east-1 --output json | jq -r .Reservations[].Instances[].PublicIpAddress)
tag=$(aws ec2 describe-instances --filter Name=instance-state-name,Values=running --region us-east-1 --output json | jq -r .Reservations[].Instances[].Tags[])
privateip=$(aws ec2 describe-instances --filter Name=instance-state-name,Values=running --region us-east-1 --output json | jq -r .Reservations[].Instances[].PrivateIpAddress)
# shellcheck disable=SC1012
echo instances "${instances}"
echo EIP: "${eip}"
echo PrivateIP: "${privateip}"
echo Tags: "${tag}"
