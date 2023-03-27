# based on a slim image
FROM python:3.10-slim

WORKDIR /usr/src/app

RUN \
    # APT packages for UML
    apt-get update \
    # Python packages for Sphinx
    && python -m venv .venv \
    && . .venv/bin/activate \
    && pip install jupyter-book \
    && pip install sphinxcontrib-plantuml

EXPOSE 8000