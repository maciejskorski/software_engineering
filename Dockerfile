# use slim Python and Java Runtime Environment images 

# APT packages and JRE to plot UML
FROM openjdk:8-jre-slim as java_docker
WORKDIR /usr/local/bin
RUN apt-get -y update
RUN apt-get install -y wget
RUN wget https://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar 
RUN apt-get install -y libfreetype6
COPY src/plantuml /usr/local/bin/
COPY src/diagram.wsd .
RUN chmod +x plantuml
RUN echo "$(whereis java)"

# + Python packages for Sphinx and UML
FROM python:3.10-slim AS python_docker
WORKDIR /usr/local/
COPY --from=java_docker /usr/local/ /usr/local/
RUN echo "$(ls /usr/local/)"
RUN export PATH=$PATH:/usr/local/openjdk-8/bin:/usr/bin
RUN echo "$(whereis java)"
RUN plantuml
RUN pip install jupyter-book
RUN pip install sphinxcontrib-plantuml
RUN \
    apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get -y install git


EXPOSE 8000
