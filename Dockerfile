FROM golang:1.22 as golang

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main .

#Final stage - Distroless image

FROM gcr.io/distroless/base

COPY --from=golang /app/main .

COPY --from=golang /app/static ./static

EXPOSE 8080

CMD ["./main"]
