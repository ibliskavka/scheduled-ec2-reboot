#!/bin/bash -v
set -e                                        # Fail script on error

PROFILE=${1:-"lsw"}                           # AWS Profile to use for deploy
REGION=${2:-"us-east-1"}                      # Deployment Region
BUCKET=${3:-"lsw.serverless"}                 # Artifact Bucket - must be created beforehand

STACK_NAME="scheduled-ec2-reboot-example"

# Every day at 12 PM UTC
SCHEDULE="\"cron(0 12 * * ? *)\""
EC2_ID_CSV="test,test"

sam build  --region $REGION --profile $PROFILE --debug

sam validate -t .aws-sam/build/template.yaml --region $REGION --profile $PROFILE --debug

sam deploy \
  -t .aws-sam/build/template.yaml \
  --stack-name $STACK_NAME \
  --s3-bucket $BUCKET \
  --s3-prefix $STACK_NAME \
  --parameter-overrides \
    ParameterKey=Schedule,ParameterValue="$SCHEDULE" \
    ParameterKey=Ec2Instances,ParameterValue="$EC2_ID_CSV" \
  --capabilities CAPABILITY_IAM \
  --region $REGION \
  --profile $PROFILE