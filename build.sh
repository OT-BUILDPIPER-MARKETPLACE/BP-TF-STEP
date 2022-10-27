#!/bin/bash
source functions.sh

echo "Manage the tf code available at [$WORKSPACE] and have mounted at [$CODEBASE_DIR]"
sleep  $SLEEP_DURATION


cd  $WORKSPACE/${CODEBASE_DIR}
logInfoMessage "terraform $INSTRUCTION"

terraform $INSTRUCTION

if [ $? -eq 0 ]
then
    logInfoMessage "Congratulations tf execution succeeded!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} build true "Congratulations tf execution succeeded"
elif [ $VALIDATION_FAILURE_ACTION == "FAILURE" ]
    then
    logErrorMessage "Please check tf execution failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} false "Please check tf execution failed!!!"
    exit 1
    else
    logWarningMessage "Please check tf execution failed!!!"
    generateOutput ${ACTIVITY_SUB_TASK_CODE} true "Please check tf execution failed!!!"
fi