# Build stage
FROM golang:1.17-alpine3.13 as builder

WORKDIR /app
COPY . .
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz
RUN ls


# Run stage
FROM alpine:3.13
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env .
COPY startup.sh .
COPY wait-for.sh .
RUN chmod +x wait-for.sh
COPY db/migration ./migration


EXPOSE 8080
CMD ["/app/main"]
ENTRYPOINT ["/app/startup.sh"]

