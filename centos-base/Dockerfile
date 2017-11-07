FROM centos:centos7.3.1611

ENV DD_API_KEY=xxxxxxxxxxxxxxx \
	DD_INSTALL_ONLY=true \
	DOCKER_DD_AGENT=yes \
    AGENT_VERSION=1:5.17.2-1 \
    DD_ETC_ROOT=/etc/dd-agent \
    PATH="/opt/datadog-agent/embedded/bin:/opt/datadog-agent/bin:${PATH}" \
    PYTHONPATH=/opt/datadog-agent/agent \
    DD_CONF_SD_JMX_ENABLE=yes \
    DD_CONF_LOG_TO_SYSLOG=no \
    NON_LOCAL_TRAFFIC=yes \
    DD_SUPERVISOR_DELETE_USER=yes

RUN yum -y install epel-release \
    && yum -y update \
    && yum -y install which java-1.8.0-openjdk-devel-1.8.0.151

RUN yum makecache fast && yum -y install python-setuptools && easy_install pip && pip install supervisor

#datadog agent install
RUN bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"

RUN mkdir /etc/datadog && \
 	chmod -R 777 /opt && \
 	chmod -R 777 /var && \
 	chmod -R 777 /etc

RUN touch /opt/datadog-agent/run/datadog-supervisor.sock && chmod 777 /opt/datadog-agent/run/datadog-supervisor.sock

RUN chmod -R 777 /var/log/datadog/

RUN mkdir /var/run/supervisor && chmod 777 /var/run/supervisor
COPY supervisor.conf "/etc/dd-agent/supervisor.conf"

COPY entrypoint.sh /entrypoint.sh

RUN chmod 777 /entrypoint.sh

COPY conf.d/*.yaml /etc/dd-agent/conf.d

COPY datadog.conf /etc/dd-agent/datadog.conf

USER nobody

ENTRYPOINT ["/entrypoint.sh"]
CMD ["supervisord", "-n", "-u","nobody", "-c", "/etc/dd-agent/supervisor.conf"]
