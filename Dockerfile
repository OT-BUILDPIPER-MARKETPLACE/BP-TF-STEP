FROM hashicorp/terraform

WORKDIR /home/buildpiper

RUN apk --no-cache add \
    bash aws-cli jq gettext libintl curl python3 py3-pip py3-virtualenv docker-cli && \
    addgroup -g 65522 buildpiper && \
    adduser -D -h /home/buildpiper -u 65522 -G buildpiper buildpiper && \
    mkdir -p /home/buildpiper && \
    chown -R buildpiper:buildpiper /home/buildpiper

RUN apk add --no-cache --upgrade bash

ENV SLEEP_DURATION 5s

COPY build.sh .
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

ENV INSTRUCTION "plan"

ENTRYPOINT [ "./build.sh" ]
