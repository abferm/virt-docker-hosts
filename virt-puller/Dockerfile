FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y wget libguestfs-tools linux-image-generic

ADD get-images.sh /

WORKDIR /work/

ENTRYPOINT [ "/get-images.sh" ]