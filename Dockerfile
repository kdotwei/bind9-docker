FROM debian:bookworm

WORKDIR /app

RUN apt update
RUN apt upgrade -y
RUN apt install -y bind9 bind9utils bind9-doc

COPY ./configs /app

RUN cp -f * /etc/bind/

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]