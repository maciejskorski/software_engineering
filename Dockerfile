# minimal Java Runtime Environment tailored to run plantuml
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
FROM python:3.10-alpine AS python_docker
WORKDIR /usr/local
COPY --from=java_docker /usr/local/bin/plantuml* ./bin/
COPY --from=java_docker /usr/local/bin/jre ./bin/jre
ENV PATH=$PATH:/usr/local/bin/:/usr/local/bin/jre/bin/
## system packages for ghpages deployment: git, vector graphics package, fonts
RUN apk update \
    && apk add --no-cache fontconfig ttf-dejavu \
    && apk add --no-cache git graphviz
## Python packages for documentation + temporary sys packages to build them
RUN  apk add --no-cache build-base linux-headers \
    && pip install --no-cache-dir --upgrade pip jupyter-book sphinxcontrib-plantuml \
    && apk del build-base linux-headers \
    && rm -rf /var/cache/apk/*

CMD ["/bin/sh"]