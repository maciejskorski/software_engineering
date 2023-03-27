# based on a slim image
FROM python:3.10-slim

# copy Docker file to working dir
WORKDIR /usr/src/app
COPY Dockerfile .

RUN \
    # APT packages for UML
    apt-get update \
    apt-get install git \
    # Python packages for Sphinx
    && pip install jupyter-book \
    && pip install sphinxcontrib-plantuml

EXPOSE 8000