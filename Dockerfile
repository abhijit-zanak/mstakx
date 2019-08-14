FROM alpine:latest as build

ADD https://download.java.net/java/early_access/alpine/16/binaries/openjdk-13-ea+16_linux-x64-musl_bin.tar.gz /opt/jdk/
RUN tar -xzvf /opt/jdk/openjdk-13-ea+16_linux-x64-musl_bin.tar.gz -C /opt/jdk/

RUN ["/opt/jdk/jdk-13/bin/jlink", "--compress=2", \
     "--module-path", "/opt/jdk/jdk-13/jmods/", \
     "--add-modules", "java.base", \
     "--output", "/jlinked"]

FROM alpine:latest
COPY --from=build /jlinked /opt/jdk/
CMD ["/opt/jdk/bin/java", "--version"]
