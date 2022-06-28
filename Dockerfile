# syntax=docker/dockerfile:1

ARG GO_VERSION=1.18.3

FROM golang:${GO_VERSION}-bullseye as build

WORKDIR /go/src/app
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 go build -o /go/bin/fenix

FROM gcr.io/distroless/static-debian11
COPY --from=build /go/bin/fenix /

ENTRYPOINT ["/fenix"]