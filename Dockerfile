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
RUN ls -la ${HOME}/build/libs/  # 確認用
#
# Package stage
#
FROM amazoncorretto:17-alpine
ARG WORKDIR
ENV HOME=${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0
COPY --from=builder ${HOME}/build/libs/demo-0.0.1-SNAPSHOT demo-0.0.1-SNAPSHOT
EXPOSE 8080
ENTRYPOINT ["java","-jar","demo-0.0.1-SNAPSHOT"]