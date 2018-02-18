#!/bin/bash

aws cloudformation create-change-set --stack-name=cloud9-herokuCloudwatchSync --change-set-name=$1 --capabilities CAPABILITY_IAM --template-body=file://aws/cloudformation/heroku-cloudwatch-sync.yaml

