FROM alpine:3.7

# Godep for vendoring
RUN mkdir -p /opt/sysmon
ADD sysmon.tar.gz /opt/sysmon
RUN sed -i 's/runmode = dev/runmode = prod/g' /opt/sysmon/conf/app.conf

RUN echo "#!/bin/sh" > /opt/run.sh && echo "cd /opt/sysmon && ./sysmon > /var/log/sysmon.log &" >> /opt/run.sh && echo "/bin/sh" >> /opt/run.sh && chmod a+x /opt/run.sh

WORKDIR /opt
ENTRYPOINT [ "/opt/run.sh" ]

EXPOSE 2048
