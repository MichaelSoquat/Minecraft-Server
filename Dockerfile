FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && \
    apt-get install -y wget openjdk-21-jdk && \
    rm -rf /var/lib/apt/lists/*

COPY server.jar /app/
RUN echo "eula=true" > eula.txt

EXPOSE 25565

ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
