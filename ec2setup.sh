#!/usr/bin/env bash

if [ -x $AWS_DEFAULT_REGION ]; then
  echo "AWS_DEFAULT_REGION env var not set"
  exit 1
elif [ -x $AWS_DEFAULT_ZONE ]; then
  echo "AWS_DEFAULT_ZONE env var not set"
  exit 1
elif [ -x $AWS_ACCESS_KEY_ID ]; then
  echo "AWS_ACCESS_KEY_ID env var not set"
  exit 1
elif [ -x $AWS_SECRET_ACCESS_KEY ]; then
  echo "AWS_SECRET_ACCESS_KEY env var not set"
  exit 1
fi

jq --version &>/dev/null
if [ $? -ne 0 ]; then
  echo "jq is missing"
  exit 1
fi

aws ec2 describe-regions --region-names $AWS_DEFAULT_REGION 1>/dev/null
if [ $? -ne 0 ]; then
  echo "Error while validating region"
  exit 1
fi

aws ec2 describe-availability-zones --zone-names $AWS_DEFAULT_ZONE 1>/dev/null
if [ $? -ne 0 ]; then
  echo "Error while validating zone"
  exit 1
fi

aws sts get-caller-identity 1>/dev/null
if [ $? -ne 0 ]; then
  echo "Error while validating credentials"
  exit 1
fi
