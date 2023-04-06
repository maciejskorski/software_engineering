# use slim Python and Java Runtime Environment images 

# APT packages and JRE to plot UML
FROM openjdk:8-jre-slim as openjdk
WORKDIR /usr/local/bin
RUN apt-get -y update
RUN apt-get install -y wget
RUN wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar 
COPY src/plantuml .
RUN chmod +x plantuml

# + Python packages for Sphinx and UML
FROM python:3.10-slim AS python
WORKDIR /usr/src/app
COPY --from=openjdk /usr/local /usr/local
RUN export PATH=$PATH:/usr/local/openjdk-8/bin/:/usr/bin/
RUN echo "$(whereis java)"
RUN pip install jupyter-book
RUN pip install sphinxcontrib-plantuml
RUN \
    apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get -y install git
RUN plantuml

EXPOSE 8000
