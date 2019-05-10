
######## Start from golang:1.12 for building #######
FROM golang:1.12 AS builder

WORKDIR /app
ENV GO111MODULE=on
COPY . .
RUN go mod download
RUN make build-docker

######## Start a new stage from scratch #######
FROM alpine:latest  

RUN apk --no-cache add ca-certificates

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/go-scaffold /usr/local/bin/

RUN adduser -D executor
USER executor
EXPOSE 8080
ENTRYPOINT ["go-scaffold"]