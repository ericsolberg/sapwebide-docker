FROM debian:wheezy

MAINTAINER Eric Solberg "eric.solberg@sap.com"

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
ENV JRE8_VER 45
ENV JRE8_BUILD b14
ENV JRE8_DIR /usr/lib/java
ENV WEBIDE_DIR /usr/local/SAPWebIDE

# Install needed tools
RUN apt-get update && apt-get -y install ca-certificates wget unzip

# Download & install Java
RUN \
  mkdir /install && cd /install && \
  wget --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u${JRE8_VER}-${JRE8_BUILD}/jre-8u${JRE8_VER}-linux-x64.tar.gz && \
  mkdir $JRE8_DIR && \
  tar -zxf /install/jre-8u${JRE8_VER}-linux-x64.tar.gz -C $JRE8_DIR

# Define JRE_HOME
ENV JRE_HOME $JRE8_DIR/jre1.8.0_${JRE8_VER}

# Link to /usr/bin and inform Debian about Java
# This should also put java on the path in /usr/bin/java
RUN \
  update-alternatives --install /usr/bin/java java $JRE_HOME/bin/java 1 && \
  update-alternatives --set java $JRE_HOME/bin/java

# Create SAPWebIDE directory
# and download & unzip Orion
RUN \
  cd /install && \
  wget http://mirror.cc.vt.edu/pub/eclipse/orion/drops/R-8.0-201502161823/eclipse-orion-8.0-linux.gtk.x86_64.zip && \
  mkdir $WEBIDE_DIR && cd $WEBIDE_DIR && \
  unzip /install/eclipse-orion-8.0-linux.gtk.x86_64.zip

# Download and unzip standalone P2 director
RUN \
  cd /install && \
  wget http://www.gtlib.gatech.edu/pub/eclipse/tools/buckminster/products/director_latest.zip && \
  cd $WEBIDE_DIR && \
  unzip /install/director_latest.zip

# Load the WEB IDE install zip
ADD SAP_Web_IDE_Local_Inst.zip /install/

# Unzip the installer
RUN \
  cd /install && \
  unzip SAP_Web_IDE_Local_Inst.zip

# Install Orion app server plugin
RUN \
  cd $WEBIDE_DIR/director && \
  ./director -repository jar:file:/install/updatesite.zip\!/ \
  -installIU com.sap.webide.orionplugin.feature.feature.group \
  -destination $WEBIDE_DIR/eclipse

# Remove install files
RUN rm -rf /install

WORKDIR $WEBIDE_DIR/eclipse
CMD ["./orion"]
