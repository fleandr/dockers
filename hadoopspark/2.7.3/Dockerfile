FROM arm64v8/ubuntu:16.04
# Install dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      curl \
      openjdk-8-jdk \
      git \
      rsync \
      ssh \
      vim \
      libblas3 \
      libgfortran3 \
      liblapack3 \
    && rm -rf /var/lib/apt/lists/*

ENV HADOOP_VERSION 2.7.3
ENV HADOOP_PREFIX /opt/hadoop-${HADOOP_VERSION}
ENV HADOOP_CONF_DIR ${HADOOP_PREFIX}/etc/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-arm64


ENV SPARK_VERSION 2.1.0
ENV HADOOP_VERSION 2.7
ENV MIRROR  https://d3kbcqa49mib13.cloudfront.net/
ENV SPARK_HOME /opt/spark-${SPARK_VERSION}

# Install Spark
RUN BUILD_DEPS="curl openjdk-8-jdk" \
    && set -x \
    && apt-get update -y && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
    && rm -rf /var/lib/apt/lists/* \
    && curl ${MIRROR}spark-${SPARK_VERSION}.tgz | tar -xzC /root \
    && export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::") \
    && cd /root/spark-${SPARK_VERSION} \
    && ./dev/change-scala-version.sh 2.11 \
    && ./dev/make-distribution.sh -Phadoop-${HADOOP_VERSION} -Pyarn -Pnetlib-lgpl  -DskipTests  \
    && mv dist /opt/spark-${SPARK_VERSION} \
    && cd /root && rm -r .zinc .m2 spark-${SPARK_VERSION} \
    && apt-get purge -y --auto-remove ${BUILD_DEPS}



RUN apt-get update -y && apt-get install -y --no-install-recommends \
      curl \
      openjdk-8-jdk \
      maven \
      python 

# Install Hadoop
RUN set -x \
    && URL=ftp://apache.belnet.be/mirrors/ftp.apache.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz \
    && curl ${URL} | tar -xzC /opt

# Configure Hadoop
RUN sed -i "s:JAVA_HOME=.*:JAVA_HOME=${JAVA_HOME}:" ${HADOOP_PREFIX}/etc/hadoop/hadoop-env.sh

# Configure ssh
RUN ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys \
    && echo "Host *\n  StrictHostKeyChecking no" > /root/.ssh/config

COPY files /root/
ENV SPARK_MASTER_PORT 7077
ENV SPARK_WEBUI_PORT 8080
EXPOSE ${SPARK_MASTER_PORT} ${SPARK_WEBUI_PORT}
COPY files/*-site.xml ${HADOOP_PREFIX}/etc/hadoop/
COPY files/entrypoint.sh files/example_benchmark.sh /root/
RUN chmod +x /root/entrypoint.sh /root/example_benchmark.sh
RUN git clone -b 6.0 https://github.com/intel-hadoop/HiBench.git

ENTRYPOINT ["/root/entrypoint.sh"]
