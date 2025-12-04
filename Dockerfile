FROM hashicorp/terraform

# Create group and user in Alpine
RUN addgroup -g 65522 buildpiper && \
    adduser -D -u 65522 -G buildpiper -h /home/buildpiper buildpiper && \
    chown -R buildpiper:buildpiper /home/buildpiper

RUN apk add --no-cache --upgrade bash
RUN apk add --no-cache jq
RUN apk add --no-cache aws-cli

RUN mkdir -p \
        /src/reports \
        /bp/data \
        /bp/execution_dir \
        /opt/buildpiper/shell-functions \
        /opt/buildpiper/data \
        /bp/workspace && \
    chown -R buildpiper:buildpiper /src /bp /opt

ENV SLEEP_DURATION=5s

COPY --chown=buildpiper:buildpiper build.sh /home/buildpiper/build.sh
COPY --chown=buildpiper:buildpiper BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/

RUN chmod +x /home/buildpiper/build.sh && \
    chown -R buildpiper:buildpiper /bp/workspace && \
    mkdir -p /home/buildpiper/reports && \
    chown -R buildpiper:buildpiper /home/buildpiper

USER buildpiper
WORKDIR /home/buildpiper

ENTRYPOINT [ "./build.sh" ]
