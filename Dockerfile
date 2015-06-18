FROM java:8u40-jdk
MAINTAINER Patrick Davis <patrick_davis@cable.comcast.com>

ENV CATALINA_HOME="/usr/local/tomcat" 
ENV PATH=$CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"

#Add the tomcat version with configs 
#need to figure out if war files should be auto-deploy or manual-deploy via manager
#ADD ./ $CATALINA_HOME

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

EXPOSE 8080

CMD ["catalina.sh", "run"]