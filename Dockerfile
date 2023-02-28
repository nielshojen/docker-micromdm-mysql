FROM golang:alpine as builder

RUN apk add --no-cache make git
RUN git clone https://github.com/Lepidopteron/micromdm.git /go/src/github.com/micromdm/micromdm && git -C /go/src/github.com/micromdm/micromdm checkout tags/v1.10.1

WORKDIR /go/src/github.com/micromdm/micromdm/

ENV CGO_ENABLED=0 \
	GOARCH=amd64 \
	GOOS=linux

RUN make deps
RUN make

FROM alpine

VOLUME "/repo"

#COPY docker-entrypoint.d /docker-entrypoint.d
#COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apk --update add ca-certificates
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/micromdm /usr/local/bin/
COPY --from=builder /go/src/github.com/micromdm/micromdm/build/linux/mdmctl /usr/local/bin/
RUN chmod a+x /usr/local/bin/micromdm
RUN chmod a+x /usr/local/bin/mdmctl
#RUN chmod +x /docker-entrypoint.d/*.sh
#RUN chmod a+x /docker-entrypoint.sh

EXPOSE 80 443 8080

#ENTRYPOINT ["/docker-entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/micromdm", "serve"]