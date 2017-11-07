FROM datadog/docker-dd-agent

ENV DOCKER_DD_AGENT=yes \
    AGENT_VERSION=1:5.17.2-1 \
    DD_ETC_ROOT=/etc/dd-agent \
    PATH="/opt/datadog-agent/embedded/bin:/opt/datadog-agent/bin:${PATH}" \
    PYTHONPATH=/opt/datadog-agent/agent \
    DD_CONF_LOG_TO_SYSLOG=no \
    NON_LOCAL_TRAFFIC=yes \
    DD_SUPERVISOR_DELETE_USER=yes

RUN mkdir /etc/datadog
RUN chmod -R 777 /opt && chmod -R 777 /var && chmod -R 777 /etc/datadog && chmod -R 777 /etc/dd-agent/

RUN chmod -R 777 /etc

RUN touch /opt/datadog-agent/run/datadog-supervisor.sock && chmod 777 /opt/datadog-agent/run/datadog-supervisor.sock

RUN mkdir /var/run/supervisor && chmod 777 /var/run/supervisor
COPY supervisor.conf "/etc/dd-agent/supervisor.conf"
COPY conf.d/* /etc/dd-agent/conf.d
USER nobody

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-u","nobody", "-c", "/etc/dd-agent/supervisor.conf"]