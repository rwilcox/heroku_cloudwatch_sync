About
==========================

I like Heroku as a first destination for new projects. Heroku has a couple addons for log management, but AWS CloudWatch Logs is a super low cost place for log files, and a relatively known quantity operationally.

With a serverless solution I'm only charged for computing resources I use: important for situations where Heroku's free tier may power down the unused instance.

TODO:
========================

  * s3 bucket needs to be created (and have lambda package uploaded) before running CFN
  * upload zip file to s3 bucket
  * split s3 bucket creation off from rest of it, as S3 key must exist for lambda resource to be created

Credit:
==========================

  * [On aws cloudformation package and references in CodeURI](https://github.com/awslabs/serverless-application-model/issues/61#issuecomment-311066225)
  * Basis for Makefile: [jc2k's blog post on using make for Python Lambda functions](https://unrouted.io/2016/07/21/use-make/)
  * Basis for reading Heroku flush info: [Mischa Spiegelmock's Heroku logging to Slack implementation](https://spiegelmock.com/2017/10/26/heroku-logging-to-aws-lambda/)
