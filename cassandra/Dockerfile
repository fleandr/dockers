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
      autoconf \
      tar g++ make automake libtool wget patch libx11-dev libxt-dev pkg-config texinfo locales-all 
RUN apt-get install -y --no-install-recommends ant ant-optional python unzip
      
 


ENV JAVA_TOOL_OPTIONS "-Dfile.encoding=UTF8"
ENV LANG "en_US.UTF-8"
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-arm64
ENV ANT_HOME /usr/share/ant
ENV PATH $PATH:$ANT_HOME/bin
ENV ANT_OPTS	"-Xms4G -Xmx4G"
COPY files/entrypoint.sh files/example_benchmark.sh /root/
RUN chmod +x /root/entrypoint.sh /root/example_benchmark.sh
RUN git clone -b cassandra-3.11 https://github.com/apache/cassandra.git

ENTRYPOINT ["/root/entrypoint.sh"]
