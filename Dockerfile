FROM openjdk:17-jdk

ARG WORKDIR
ARG JAR_FILE=build/libs/*.jar

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0

WORKDIR ${HOME}

RUN microdnf install findutils