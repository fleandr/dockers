FROM  arm64v8/ubuntu:16.04

# Install dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      libblas3 \
      libgfortran3 \
      liblapack3 \
      openjdk-8-jdk \
      git 

ENV SPARK_VERSION 2.3.0
ENV HADOOP_VERSION 2.7
ENV SPARK_HOME /opt/spark-${SPARK_VERSION}

# Install Spark
RUN BUILD_DEPS="curl openjdk-8-jdk" \
    && set -x \
    && apt-get update -y && apt-get install -y --no-install-recommends ${BUILD_DEPS} \
    && rm -rf /var/lib/apt/lists/* \
    && git clone -b branch-2.3 https://github.com/apache/spark.git \
    && export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::") \
    && mv spark /root/spark-${SPARK_VERSION} \
    && cd /root/spark-${SPARK_VERSION} \
    && ./dev/change-scala-version.sh 2.11 \
    && ./dev/make-distribution.sh -Phadoop-${HADOOP_VERSION} -Pyarn -Pnetlib-lgpl  -DskipTests  \
    && mv dist /opt/spark-${SPARK_VERSION} \
    && cd /root && rm -r .zinc .m2 spark-${SPARK_VERSION} \
    && apt-get purge -y --auto-remove ${BUILD_DEPS}

COPY files /root/
RUN apt-get update -y && apt-get install -y openjdk-8-jdk 
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-arm64

# Expose Spark ports
ENV SPARK_MASTER_PORT 7077
ENV SPARK_WEBUI_PORT 8080
EXPOSE ${SPARK_MASTER_PORT} ${SPARK_WEBUI_PORT}

ENTRYPOINT ["/root/entrypoint.sh"]
