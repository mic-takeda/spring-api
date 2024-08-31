#
# Build stage
#
FROM amazoncorretto:17 AS builder
ARG WORKDIR

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0
WORKDIR ${HOME}
COPY ./ ${HOME}
RUN chmod +x gradlew   # gradlew に実行権限を付与
RUN ./gradlew build
#
# Package stage
#
FROM amazoncorretto:17-alpine
ARG WORKDIR
ENV HOME=${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0
COPY --from=builder ${HOME}/build/libs/share-favplace-api-0.0.1-SNAPSHOT.jar share-favplace-api.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","share-favplace-api.jar"]