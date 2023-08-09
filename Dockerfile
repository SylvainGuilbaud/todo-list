ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.1.380.0
ARG IMAGE=intersystems/irishealth-community:2023.2.0.227.0
ARG IMAGE=intersystems/iris-community:2023.2.0.227.0
ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.2.0.227.0

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

# copy the modified index.html which replaces the default URL of the swagger-ui by :
# http://localhost:32773/api/mgmnt/v1/IRISAPP/spec/front-end/api
COPY swagger-ui/index.html /usr/irissys/csp/swagger-ui/index.html