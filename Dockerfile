ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:latest-cd
# ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-cd
# ARG IMAGE=intersystemsdc/iris-community:latest  

FROM $IMAGE as builder

WORKDIR /home/irisowner/dev

ARG TESTS=0
ARG MODULE="todo-list"
ARG NAMESPACE="IRISAPP"

ENV IRISUSERNAME "_SYSTEM"
ENV IRISPASSWORD "SYS"
ENV IRISNAMESPACE $NAMESPACE

RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly

FROM $IMAGE as final
ADD --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} https://github.com/grongierisc/iris-docker-multi-stage-script/releases/latest/download/copy-data.py /home/irisowner/dev/copy-data.py

RUN --mount=type=bind,source=/,target=/builder/root,from=builder \
    cp -f /builder/root/usr/irissys/iris.cpf /usr/irissys/iris.cpf && \
    python3 /home/irisowner/dev/copy-data.py -c /usr/irissys/iris.cpf -d /builder/root/
