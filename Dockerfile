
######## Start from golang:1.12 for building #######
FROM golang:1.12 AS builder

RUN apk update && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates

WORKDIR /app
ENV GO111MODULE=on
COPY . .
RUN go mod download
RUN make build-docker

######## Start a new stage from scratch #######
FROM scratch

COPY --from=builder /app/go-scaffold /usr/local/bin/
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
RUN adduser -D executor
USER executor

######## Modify after this line ########

EXPOSE 8080
ENTRYPOINT ["go-scaffold"]