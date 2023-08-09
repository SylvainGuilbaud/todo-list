ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.1.380.0
FROM $IMAGE

USER root
WORKDIR /app
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /app

USER ${ISC_PACKAGE_MGRUSER}
COPY App.Installer.cls .
COPY src src
COPY iris.script /tmp/iris.script

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly
COPY swagger-ui/index.html /usr/irissys/csp/swagger-ui/index.html