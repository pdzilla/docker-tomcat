FROM java:8u40-jdk
MAINTAINER Patrick Davis <patrick_davis@cable.comcast.com>

ENV CATALINA_HOME="/usr/local/tomcat" 
ENV PATH=$CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"

WORKDIR $CATALINA_HOME

# Build on Red, Blue or Agile for internets
ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.20
ENV TOMCAT_DL_URL http://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
RUN set -x \
	&& curl -fSL "$TOMCAT_DL_URL" -o tomcat.tar.gz \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomcat.tar.gz

### remove the closing tag, then use the echo|tee pattern to build it back in
RUN sed -i 's|</tomcat-users>| |' $CATALINA_HOME/conf/tomcat-users.xml
RUN echo "<role rolename=\"admin\" />" | tee -a $CATALINA_HOME/conf/tomcat-users.xml \
	&& echo "<user username=\"${MANAGER_USER:-admin}\" password=\"${MANAGER_PW:-password}\" roles=\"standard,manager,admin,admin-gui,manager-gui,manager-status,manager-script\"/>" | tee -a $CATALINA_HOME/conf/tomcat-users.xml \
	&& echo "</tomcat-users>" | tee -a $CATALINA_HOME/conf/tomcat-users.xml

### setup setenv.sh
RUN echo "CATALINA_PID=\"\$CATALINA_HOME/bin/catalina.pid\"" | tee $CATALINA_HOME/bin/setenv.sh
RUN echo "CATALINA_OPTS=\"\$CATALINA_OPTS -Xms512m -Xmx1024m -Denv=${TOMCAT_ENV:-local} \
  -Dlogging_override=file://$CATALINA_HOME/servicebus_logging_override.xml \
  -Doverride_file=$CATALINA_HOME/servicebus_override.properties\"" | \
  	tee -a $CATALINA_HOME/bin/setenv.sh \
	&& chmod 755 $CATALINA_HOME/bin/setenv.sh

EXPOSE 8080

CMD ["catalina.sh", "run"]