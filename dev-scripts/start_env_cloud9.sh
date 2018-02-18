#!/bin/bash

aws cloudformation create-stack --stack-name=heroku-cloudwatch-sync-lambda-dev --template-body=file://aws/cloudformation/supporting/Cloud9DevBox.yml
