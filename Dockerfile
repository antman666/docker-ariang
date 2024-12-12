FROM lsiobase/alpine:latest as builder

RUN apk add --no-cache curl unzip \
&& ARIANG_VER=$(wget -qO- https://api.github.com/repos/mayswind/AriaNg/tags | grep 'name' | cut -d\" -f4 | head -1 ) \
&& wget -P /tmp https://github.com/mayswind/AriaNg/releases/download/${ARIANG_VER}/AriaNg-${ARIANG_VER}-AllInOne.zip \
&& unzip /tmp/AriaNg-${ARIANG_VER}-AllInOne.zip -d /tmp

FROM p3terx/darkhttpd
# set label
LABEL maintainer="antman666"
# copy AriaNg
COPY --from=builder /tmp/index.html /www/index.html
# darkhttpd port
EXPOSE 6880
# start darkhttpd
ENTRYPOINT [ "/darkhttpd" ]
CMD [ "/www" ]
