FROM golang:1.24 AS build

WORKDIR /build

COPY go.mod go.sum ./
RUN go mod download

COPY server/ ./server/

RUN CGO_ENABLED=0 GOOS=linux go build -o kubeview \
  -ldflags "-X 'main.version=0.0.0' -X 'main.buildInfo=Unset'" \
  ./server

FROM gcr.io/distroless/static-debian11

WORKDIR /app

COPY --from=build /build/kubeview .
COPY public/ ./public/

ENV PORT=8000
EXPOSE 8000

CMD ["./kubeview"]