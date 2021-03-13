FROM openjdk:11-jre-slim

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y telnet
RUN apt-get install -y gnupg

RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" \
        | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN apt-get update
RUN apt-get install -y mongodb-org-shell

ENTRYPOINT ["tail", "-f", "/dev/null"]