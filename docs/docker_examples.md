# Class 7: Using Docker

The content of `Dockerfile` looks as follows:
```{docker}
# use slim Python and Java Runtime Environment images 

# APT packages and JRE to plot UMLs
FROM openjdk:8-jre-slim as java_docker
WORKDIR /usr/local/bin
RUN apt-get -y update \
    && apt-get install -y wget \
    && wget https://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar 
COPY src/plantuml /usr/local/bin/
RUN chmod +x plantuml

# + Python packages for Sphinx and UML (with dependencies)
FROM python:3.10-slim AS python_docker
WORKDIR /usr/local/
COPY --from=java_docker /usr/local/ /usr/local/
ENV PATH=$PATH:/usr/local/openjdk-8/bin
RUN pip install jupyter-book \
    && pip install sphinxcontrib-plantuml
RUN apt-get -y update \
    && apt-get install -y graphviz \
    && apt-get -y install git

EXPOSE 8000
```


## More

* An article on [best docker practices](https://testdriven.io/blog/docker-best-practices/)