#!/bin/bash

aws cloudformation create-stack --stack-name=heroku-cloudwatch-sync-lambda --template-body=file://aws/cloudformation/heroku-cloudwatch-sync.yaml
