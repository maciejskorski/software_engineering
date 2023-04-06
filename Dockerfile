# based on a slim image
FROM python:3.10-slim

WORKDIR /usr/src/app

RUN \
    # APT packages for UML
    apt-get -y update \
    && apt-get install default-jre -y \
    && apt-get graphviz -y \
    && wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar \
    && mv plantuml.jar /usr/bin \
    && apt-get -y install git \
    # Python packages for Sphinx and UML
    && pip install jupyter-book \
    && pip install sphinxcontrib-plantuml

EXPOSE 8000