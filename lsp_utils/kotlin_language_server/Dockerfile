FROM docker.io/openjdk:11.0.13-slim-bullseye

WORKDIR /app
RUN apt-get update && apt-get upgrade -y && apt-get install git -y
RUN git clone https://github.com/fwcd/kotlin-language-server.git && \
  cd ./kotlin-language-server && \
  ./gradlew :server:installDist
