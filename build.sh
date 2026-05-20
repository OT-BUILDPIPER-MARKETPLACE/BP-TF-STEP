#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh


tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update terraform code available at [$tfCodeLocation]"

cd  "${tfCodeLocation}"


logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"
if [ "$ASSUME_OTHER_ROLE" == true ]
then
	role_output=$(aws sts assume-role --role-arn arn:aws:iam::$ACCOUNT_ID:role/$ROLE_NAME --role-session-name $ROLE_SESSION_NAME)

	if [ $? -ne 0 ]; then
	  echo "Failed to assume role."
	  exit 1
	fi

	AWS_ACCESS_KEY_ID=$(echo $role_output | jq -r '.Credentials.AccessKeyId')
	AWS_SECRET_ACCESS_KEY=$(echo $role_output | jq -r '.Credentials.SecretAccessKey')
	AWS_SESSION_TOKEN=$(echo $role_output | jq -r '.Credentials.SessionToken')

	# Export the variables
	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	export AWS_SESSION_TOKEN
fi

terraform init
case "$INSTRUCTION" in

  plan)
    terraform init
    terraform plan -var-file="terraform.tfvars"
    ;;

  apply)
    terraform apply -auto-approve -var-file="terraform.tfvars"
    ;;

  destroy)
    terraform destroy -auto-approve -var-file="terraform.tfvars"
    ;;

  validate)
    terraform validate
    ;;

  state)
    terraform state list
    ;;

  refresh)
    terraform refresh -auto-approve -var-file="terraform.tfvars"
    ;;
  
  output)
    terraform output
    ;;

# IMPORT_RESOURCE_ADDRESS=aws_s3_bucket.my_bucket
# IMPORT_RESOURCE_ID=my-existing-bucket-name

  import)
    if [ -z "$IMPORT_RESOURCE_ADDRESS" ] || [ -z "$IMPORT_RESOURCE_ID" ]; then
      logInfoMessage "terraform import requires IMPORT_RESOURCE_ADDRESS and IMPORT_RESOURCE_ID env vars"
      exit 1
    fi
    terraform import -var-file="terraform.tfvars" "$IMPORT_RESOURCE_ADDRESS" "$IMPORT_RESOURCE_ID"
    ;;
  *)
    logInfoMessage "Not a valid option use(plan|apply|destroy|refresh|state file|validate)"
    ;;
esac
