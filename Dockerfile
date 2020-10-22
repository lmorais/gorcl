FROM golang:1.15.1-buster as build

WORKDIR /go/src/app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=1 GOOS=linux go build -o /go/bin/main main.go


FROM alpine:latest

ENV LD_LIBRARY_PATH /lib

RUN apk add --no-cache libaio libnsl libc6-compat ca-certificates && \
    wget https://download.oracle.com/otn_software/linux/instantclient/193000/instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    unzip instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    cp -r instantclient_19_3/* /lib && \
    rm -rf instantclient-basic-linux.x64-19.3.0.0.0dbru.zip && \
    rm -rf instantclient_19_3 && \
    ln -s /lib64/* /lib && cd /lib && ln -s libnsl.so.2 /usr/lib/libnsl.so.1 && ln -s libc.so.6 libresolv.so.2

COPY --from=build /go/bin/main /bin/main

CMD ["/bin/main"]
