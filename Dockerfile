FROM java:8

ENV KAFKA_MANAGER_VERSION 1.3.3.4

RUN git clone https://github.com/yahoo/kafka-manager.git && cd kafka-manager \
	&& git checkout tags/$KAFKA_MANAGER_VERSION \
	&& ./sbt clean dist \
	&& unzip /kafka-manager/target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.zip -d /opt \
	&& rm -r /root/.sbt /root/.ivy2 /kafka-manager

RUN ln -s /opt/kafka-manager-$KAFKA_MANAGER_VERSION /opt/kafka-manager

# Fix logging to use only stdout
ADD logback.xml /opt/kafka-manager/conf/logback.xml

EXPOSE 9000

WORKDIR "/opt/kafka-manager"

ENTRYPOINT [ "./bin/kafka-manager", "-Dapplication.home=/opt/kafka-manager"]

