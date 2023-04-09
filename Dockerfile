# build a light Java Runtime Environment tailored to plantuml
FROM eclipse-temurin:11 as java_docker
WORKDIR /usr/local/bin
COPY src/plantuml .
COPY src/diagram.wsd .
RUN chmod +x plantuml
RUN apt-get update \
    && apt-get install -y wget \
    && wget http://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.datatransfer,java.desktop,java.logging,java.prefs,java.scripting,java.xml  \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output ./jre

# + Python packages for Sphinx and UML and some APT dependencies
FROM python:3.10-slim AS python_docker
WORKDIR /usr/local/
COPY --from=java_docker /usr/local/ /usr/local/
ENV PATH=$PATH:/usr/local/bin:/usr/local/bin/jre/bin
RUN pip install jupyter-book \
    sphinxcontrib-plantuml
RUN apt-get update \
    && apt-get install -y \
    graphviz

#RUN plantuml ./bin/diagram.wsd
#CMD ["/bin/bash"]

EXPOSE 8000