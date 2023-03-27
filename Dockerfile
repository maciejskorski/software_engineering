# based on a slim image
FROM python:3.10-slim

# copy Docker file to working dir
WORKDIR /usr/src/app
COPY Dockerfile .

RUN \
    # APT packages for UML
    apt-get -y update \
    && apt-get -y install plantuml \
    && apt-get -y install git \
    # Python packages for Sphinx and UML
    && pip install jupyter-book \
    && pip install sphinxcontrib-plantuml

EXPOSE 8000