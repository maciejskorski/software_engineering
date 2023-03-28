# based on a slim image
FROM python:3.10-slim

WORKDIR /usr/src/app

RUN \
    # APT packages for UML
    apt-get -y update \
    && apt-get -y install plantuml \
    && apt-get -y install git \
    # Python packages for Sphinx and UML
    && pip install jupyter-book \
    && pip install sphinxcontrib-plantuml

EXPOSE 8000