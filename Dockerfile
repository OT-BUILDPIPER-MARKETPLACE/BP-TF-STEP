FROM hashicorp/terraform

RUN apk add --no-cache --upgrade bash
RUN apk add jq
RUN apk add --no-cache aws-cli

ENV SLEEP_DURATION 5s

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
abc
ENV INSTRUCTION "apply"

ENTRYPOINT [ "./build.sh" ]
