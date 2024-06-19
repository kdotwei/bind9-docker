FROM debian:bookworm

WORKDIR /app

RUN apt update
RUN apt upgrade -y
RUN apt install -y bind9 bind9utils bind9-doc

COPY ./configs /app/configs
COPY ./dnskeys /app/dnskeys

RUN cp -f /app/configs/* /etc/bind/
RUN cp -f /app/dnskeys/ksk/* /var/cache/bind/
RUN cp -f /app/dnskeys/zsk/* /var/cache/bind/
RUN dnssec-signzone -o kwei.nycu.me -K /var/cache/bind/ /etc/bind/db.kwei.nycu.me

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]