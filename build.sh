#!/bin/bash
source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh

logInfoMessage "Creating for $MODULE"
tfCodeLocation="${WORKSPACE}"/"${CODEBASE_DIR}"/"${TF_CODE_LOCATION}"
logInfoMessage "I'll create/update [$MODULE] available at [$tfCodeLocation]"
sleep  "$SLEEP_DURATION"

tfvars_file_location="${TF_VAR_PATH:=terraform.tfvars}"

cd  "${tfCodeLocation}"
#cp /opt/buildpiper/modules/* .

logInfoMessage "Running below tf command"
logInfoMessage "terraform $INSTRUCTION"

terraform init

case "$INSTRUCTION" in

  plan)
    terraform plan -var-file="${tfvars_file_location}"
    ;;

  apply)
    terraform apply -auto-approve -var-file="${tfvars_file_location}"
    ;;

  destroy)
    terraform destroy -auto-approve -var-file="${tfvars_file_location}"
    ;;

  *)
    logInfoMessage "Not a valid option"
    ;;
esac
