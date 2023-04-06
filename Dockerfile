# use slim Python and Java Runtime Environment images 

# APT packages and JRE to plot UML
FROM openjdk:8-jre-slim as openjdk
WORKDIR /usr/bin
RUN apt-get -y update
RUN apt-get install -y wget
RUN wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar 
COPY /usr/bin /usr/bin
COPY /usr/local/openjdk-8 /usr/local/openjdk-8

# Python packages for Sphinx and UML
FROM python:3.10-slim AS python
WORKDIR /usr/src/app
RUN pip install --user jupyter-book
RUN pip install --user sphinxcontrib-plantuml
RUN \
    apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get -y install git \
    && export PATH=$PATH:/usr/local/openjdk-8/bin

EXPOSE 8000