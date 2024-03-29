# Base Image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Enable Networking on port 8080 (Tomcat)
EXPOSE 8080

# Copy files containing the necessary python dependencies
COPY requirements.txt /tmp/

# Installing dependencies and deleting cache
RUN apt-get update && apt-get install -y \
    locales \
    git \
    maven \
    tomcat9 \
    openjdk-8-jdk-headless \
    python3 python3-pip \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Installing python dependencies
RUN python3 -m pip install --upgrade -r /tmp/requirements.txt && \
    rm /tmp/requirements.txt

# Set the locale, Solve Tomcat issues with Ubuntu
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 CATALINA_HOME=/usr/share/tomcat9

RUN mkdir -p Data

ARG ARTIFACTORY_URL=http://artifactory-ls6.informatik.uni-wuerzburg.de/artifactory/libs-snapshot/de/uniwue

# Download maven project
ENV GTCWEB_VERSION="0.0.1-6"
RUN cd /var/lib/tomcat9/webapps && \
    wget $ARTIFACTORY_URL/GTC_Web/$GTCWEB_VERSION/GTC_Web-$GTCWEB_VERSION.war -O GTC_Web.war

# Add webapps to tomcat
RUN ln -s /var/lib/tomcat9/common $CATALINA_HOME/common && \
    ln -s /var/lib/tomcat9/server $CATALINA_HOME/server && \
    ln -s /var/lib/tomcat9/shared $CATALINA_HOME/shared && \
    ln -s /etc/tomcat9 $CATALINA_HOME/conf && \
    mkdir $CATALINA_HOME/temp && \
    mkdir $CATALINA_HOME/webapps && \
    mkdir $CATALINA_HOME/logs && \
    ln -s /var/lib/tomcat9/webapps/GTC_Web.war $CATALINA_HOME/webapps

# Put supervisor process manager configuration to container
COPY supervisord.conf .

# Start processes when container is started
CMD [ "supervisord", "-c", "supervisord.conf" ]
