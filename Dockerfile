# syntax=docker/dockerfile:1

ARG GO_VERSION=1.18.3

FROM golang:${GO_VERSION}-bullseye as build

WORKDIR /go/src/app
ADD . /go/src/app/
RUN go mod download

FROM gcr.io/distroless/static-debian11
COPY --from=build /go/src/app /

ENTRYPOINT ["./fenix"]