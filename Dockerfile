FROM ubuntu:12.04

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo


WORKDIR /home
RUN chown -R docker:docker /home
RUN chmod 755 /home

RUN mkdir scripts
COPY ./scripts scripts

USER docker

ENTRYPOINT ["tail", "-f", "/dev/null"]