FROM hashicorp/terraform

ENV SLEEP_DURATION 5s
COPY build.sh .
COPY BP-BASE-SHELL-STEPS/functions.sh .
ENV ACTIVITY_SUB_TASK_CODE TF_EXECUTE
ENV INSTUCTION plan

ENTRYPOINT [ "./build.sh" ]