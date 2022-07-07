FROM golang:alpine AS builder

WORKDIR /build
COPY . .

ENV CGO_ENABLED=0
RUN apk add --no-cache ca-certificates
RUN go build -mod=vendor -ldflags="-s -w -extldflags '-static'"

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /build/flightsim /bin/flightsim

ENTRYPOINT ["/bin/flightsim"]
CMD ["-h"]