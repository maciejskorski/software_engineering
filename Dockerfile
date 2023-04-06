# based on a slim image

FROM python:3.10-slim
WORKDIR /usr/src/app
RUN \
    # Python packages for Sphinx and UML
    pip install jupyter-book \
    && pip install sphinxcontrib-plantuml


FROM openjdk:11.0.11-jre-slim
WORKDIR /usr/bin
RUN \
    # APT packages for UML
    apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get install -y wget \
    && wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar \
    && mv plantuml.jar /usr/bin \
    && apt-get -y install git

EXPOSE 8000