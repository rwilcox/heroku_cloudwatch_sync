#!/bin/bash

aws cloudformation deploy --template=aws/cloudformation/heroku-cloudwatch-sync.yaml --stack-name=heroku-cloudwatch-sync-lambda --capabilities=CAPABILITY_IAM
