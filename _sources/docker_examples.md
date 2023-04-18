# Class 7: Using Docker

In this class we will discuss how to build and optimize a [docker](https://www.docker.com/) supporting creating UML diagrams a Java-based tool `plantuml`.


## Automation: Build and Publish Docker with GitHub Actions

* Template [this example repository](https://github.com/maciejskorski/docker-build-push) under your GitHub account
* Customize [the docker workflow](https://github.com/maciejskorski/docker-build-push/blob/main/.github/workflows/docker-image.yaml) accordingly (in particular: sign up to DockerHub and for a GitHub access token)
* Make sure that the workflow builds and publishes the provided (naive) Docker

## Working but Suboptimal Docker

The tool `plantuml` is shipped as a Java module, and needs `Java Runtime Environment` along with visualization software `graphviz` at runtime.

Hence, the content of `Dockerfile` may look as follows:
```docker
# Ubuntu-based image with Java Runtime Environment
FROM eclipse-temurin:20-jre
WORKDIR /usr/local/bin
COPY ./plantuml .
RUN chmod +x plantuml
RUN wget http://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar
RUN apt-get update \
    && apt-get install -y graphviz
```
where `plantuml` is a shell wrapper that calls the java module on input files (add it to your repo)
```shell
#!/bin/sh -e
java -jar /usr/local/bin/plantuml.jar "$@"
```

Once you build and publish this image (the size should be ~160 MB), test it (you can use [GitHub CodeSpaces](https://github.com/features/codespaces)):
* login and pull the docker from the repository
* run the docker image interactively, e.g. `docker run -it plantumldocker:latest`
* create a sample plantuml diagram `diagram.iuml` and copy into the docker container, e.g. `docker cp diagram.iuml 3689309baac3:/usr/local` where `3689309baac3` should be replaced by the container ID (check with `docker ps`)
* convert the diagram into a figure inside the container, e.g. `plantuml diagram.iuml`
* copy the figure to the host, e.g. `docker cp 3689309baac3:/usr/local/diagram.png .`

In case of problems, compare with [the working version here](https://github.com/maciejskorski/plantuml-docker).

## Optimization: Lightweight Docker

Docker optimization is important to save computational and environmental resources.
```{admonition} Docker optimization techniques
:class: tip
The general optimization strategy for Docker is to *avoid any unnecessary content*, which means
* inheriting from minimal Linux images, such as [Alpine Linux Distribution](https://www.alpinelinux.org/)
* building minimalistic environments, e.g. [use jlink to create scope-tailored JREs](https://www.baeldung.com/jlink)
* removing development tools in the end, e.g. those used for building Java/Python
* clearing cache, e.g. downloaded package sources
and so on. 
```

The following, more sophisticated, docker file consumes only 66 MB
```docker
# build a light Java Runtime Environment tailored to run plantuml
FROM eclipse-temurin:17-alpine as java_docker
WORKDIR /usr/local/bin
COPY src/plantuml .
RUN chmod +x plantuml
RUN apk update && apk add wget \
    && wget http://sourceforge.net/projects/plantuml/files/plantuml-nodot.1.2023.5.jar/download -O plantuml.jar
RUN apk add binutils
RUN $JAVA_HOME/bin/jlink \
         --add-modules java.base,java.datatransfer,java.desktop,java.logging,java.prefs,java.scripting,java.xml  \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output ./jre

# move to a lightweight image and add other dependencies
FROM alpine:latest AS base_docker
WORKDIR /usr/local
COPY --from=java_docker /usr/local/bin/plantuml* ./bin/
COPY --from=java_docker /usr/local/bin/jre ./bin/jre
ENV PATH=$PATH:/usr/local/bin:/usr/local/bin/jre/bin
## package for vector grrahics and fonts for off-screen rendering (https://hub.docker.com/r/bellsoft/liberica-openjre-alpine)
RUN apk add --no-cache graphviz fontconfig ttf-dejavu
```
For more details, visit [the DockerHub repo](https://hub.docker.com/r/maciejskorski/plantuml-docker/tags).



## More

* An article on [best docker practices](https://testdriven.io/blog/docker-best-practices/)
* Ann article on [optimizing docker images](https://linuxhint.com/optimizing-docker-images/)
