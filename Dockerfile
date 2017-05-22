FROM tomcat:8-jre8
MAINTAINER brian <brian@goatfell.com>

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

ENV ADMINTOOLS_HOME /var/tmp/admintools
ENV PATH $ADMINTOOLS_HOME/openam/bin:$PATH

WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

RUN echo $PATH

ADD OpenAM-13.5.0.war /tmp/openam.war
ADD SSOAdminTools-13.5.0.zip /tmp/ssoadmin.zip
ADD SSOConfiguratorTools-13.5.0.zip /tmp/ssoconfig.zip
ADD run /var/tmp/

RUN chmod +x /var/tmp/run \
    && unzip /tmp/openam.war -d /usr/local/tomcat/webapps/openam \
    && unzip /tmp/ssoconfig.zip -d /var/tmp/ssoconfig \
    && unzip /tmp/ssoadmin.zip -d /var/tmp/admintools \
    && rm /tmp/*.zip /tmp/*.war
#    && cp /tmp/openam-proxy.conf /etc/httpd/conf.d/

CMD ["/var/tmp/run"]
