# use slim Python and Java Runtime Environment images 

# Python packages for Sphinx and UML
FROM python:3.10-slim
WORKDIR /usr/src/app
RUN pip install jupyter-book
RUN pip install sphinxcontrib-plantuml

# APT packages and JRE to plot UML
FROM openjdk:8-jre-slim
WORKDIR /usr/bin
RUN \
    apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get install -y wget \
    && wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar \
    && apt-get -y install git

EXPOSE 8000