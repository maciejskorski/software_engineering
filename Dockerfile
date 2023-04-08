# use slim Python and Java Runtime Environment images 

## build a custom Java runtime
FROM eclipse-temurin:11 as java_docker
WORKDIR /usr/local/bin
COPY src/plantuml .
COPY src/diagram.wsd .
RUN chmod +x plantuml
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output ./jre
## add a Java library with dependencies to plot UMLs
RUN apt-get -y update \
    && apt-get install -y wget \
    && wget https://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar \
    && apt-get install -y graphviz

#ENV PATH=$PATH:/usr/local/bin/jre/bin
#RUN plantuml diagram.wsd

# APT packages and JRE to plot UMLs
#FROM openjdk:8-jre-slim as 

# + Python packages for Sphinx and UML (with dependencies)
FROM python:3.10-slim AS python_docker
WORKDIR /usr/local/
COPY --from=java_docker /usr/local/ /usr/local/
ENV PATH=$PATH:/usr/local/bin:/usr/local/bin/jre/bin
RUN pip install jupyter-book \
    && pip install sphinxcontrib-plantuml
RUN apt-get -y update \
    && apt-get -y install git

EXPOSE 8000
