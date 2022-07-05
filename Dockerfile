FROM java:8-alpine


RUN apk update && apk add wget vim curl nano bash

#RUN apk add --update ca-certificates && rm -rf /var/cache/apk/* && \
#  find /usr/share/ca-certificates/mozilla/ -name "*.crt" -exec keytool -import -trustcacerts \
#  -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt \
#  -file {} -alias {} \; && \
#  keytool -list -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts --storepass changeit

ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

RUN mkdir -p /opt/blez
WORKDIR /opt/blez

COPY . .

RUN mvn package

#ENV MVN_VER=$(grep -Eo "[a-z][0-9]*\\.[0-9]*\\.[0-9]*" pom.xml)

#RUN  target/news-$MVN_VER.gar  news-blez1.jar


EXPOSE 8898

CMD java -Xms128m -Xmx256m -jar -Dserver.port=8898 target/news-*.jar