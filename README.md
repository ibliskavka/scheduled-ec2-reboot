# Scheduled EC2 Reboot

This is a tiny lambda which can [reboot EC2 instances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RebootInstances.html) on a cron schedule.

Use this project as an example to create other scheduled maintenance scripts in your AWS environment.

## Permissions Warning

For simplicity, this lambda gets `ec2:RebootInstances` permissions automatically. If your environment requires more granular permissions, please add each instance ARN to [template.yaml](./template.yaml) line 37

## Installation

### Prerequisites

- [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- [NodeJS](https://nodejs.org/en/download/)

### Deploy Script

See [deploy.sh](./deploy.sh) for instructions on how to deploy

### Parameters

- PROFILE: Which AWS Profile to use during the deploy
- REGION: Which AWS Region to deploy to
- BUCKET: Artifact bucket used by SAM - this should be created beforehand
- STACK_NAME: The name of your CloudFormation stack
- SCHEDULE: [CRON expression](https://docs.aws.amazon.com/eventbridge/latest/userguide/scheduled-events.html)
- EC2_ID_CSV: Comma separated list of EC2 instance IDs

## Troubleshooting

Deployment errors will be visible in your AWS CloudFormation console. Look for your stack name, and see the events tab.

Lambda execution errors can be found in the AWS Lambda console. Search for the lambda function who's name starts with `{StackName}-ScheduledReboot-{...}` and check the Monitoring tab for execution history and error rates.

Additional Information: [RebootInstances Service Reference](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RebootInstances.html)