# Use latest wildlfy as base
FROM jboss/wildfly:latest
# See https://github.com/JBoss-Dockerfiles/wildfly for wildfly docker documentation

USER root
# Set the smarkdown version to use in this image.
ENV SMARKDOWN_VERSION 0.8.0
# Set the config file location
ENV SMARKDOWN_CFG /etc/smarkdown/cfg.json
ADD default_config.json $SMARKDOWN_CFG
ENV JAVA_OPTS -Dsmarkdown.cfg.file=$SMARKDOWN_CFG

ENV SCRIPT_DIR /opt/smarkdown
RUN mkdir -p $SCRIPT_DIR/tmp
ENV SMARKDOWN_ASSEMBLE_FILE=$SCRIPT_DIR/assemble.sh
ENV SMARKDOWN_THIRDPARTY_FILE=$SCRIPT_DIR/thirdparty.sh
ENV SMARKDOWN_MODULES_FILE=$SCRIPT_DIR/modules.cfg
ENV SMARKDOWN_APP_DIR $SCRIPT_DIR/tmp
ENV SMARKDOWN_LIB_DIR $SMARKDOWN_APP_DIR/WEB-INF/lib
ENV SMARKDOWN_DATA /smarkdown_data

ADD assemble.sh $SMARKDOWN_ASSEMBLE_FILE
ADD thirdparty.sh $SMARKDOWN_THIRDPARTY_FILE
ADD modules.cfg $SMARKDOWN_MODULES_FILE

RUN chmod +x $SCRIPT_DIR/*.sh \
	&& cd $SMARKDOWN_APP_DIR \
	&& curl https://repo1.maven.org/maven2/com/java-adventures/smarkdown/smarkdown-war/$SMARKDOWN_VERSION/smarkdown-war-$SMARKDOWN_VERSION.war \
	| jar -x \
	&& rm $SMARKDOWN_LIB_DIR/smarkdown-*.jar \
	&& $SMARKDOWN_ASSEMBLE_FILE \
	&& rm -Rf $SMARKDOWN_APP_DIR \
	&& mkdir -p $SMARKDOWN_DATA \
	&& echo "# This is smarkdown" > $SMARKDOWN_DATA/index.md
VOLUME /smarkdown_data

USER jboss
