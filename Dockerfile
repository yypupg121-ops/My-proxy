FROM alpine:3.20

RUN apk add --no-cache     git     build-base     openssl-dev     zlib-dev     linux-headers     curl     xxd

RUN git clone --depth 1 https://github.com/TelegramMessenger/MTProxy.git /opt/MTProxy

WORKDIR /opt/MTProxy
RUN make

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 443

CMD ["/start.sh"]
