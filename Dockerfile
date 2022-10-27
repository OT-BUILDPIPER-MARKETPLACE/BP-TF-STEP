FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash

ENV SLEEP_DURATION 5s
COPY build.sh .
COPY BP-BASE-SHELL-STEPS/functions.sh .
ENV ACTIVITY_SUB_TASK_CODE TF_EXECUTE
ENV INSTRUCTION plan

ENTRYPOINT [ "./build.sh" ]