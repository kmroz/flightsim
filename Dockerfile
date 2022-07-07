FROM golang:alpine AS builder

WORKDIR /build
COPY . .

ENV CGO_ENABLED=0
RUN go build -mod=vendor -ldflags="-s -w -extldflags '-static'"

FROM scratch
COPY --from=builder /build/flightsim /bin/flightsim

CMD ["/bin/flightsim"]
