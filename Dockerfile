FROM golang:1.15.3-buster as proto-gen-descriptor
ENV GO111MODULE=on
ENV GOPROXY=direct

# Software install and update
RUN set -ex && apt-get update && apt-get install -y --no-install-recommends \
    git \
	protobuf-compiler=3.6.1.3-2 \
	apt-utils

RUN go env
# Fetch requirements for proto compiler
RUN git clone --depth 1 https://github.com/googleapis/googleapis && \
    git clone --depth 1 https://github.com/googleapis/api-common-protos && \
    git clone --depth 1 https://github.com/protocolbuffers/protobuf
	
RUN go get google.golang.org/grpc && \
    go get google.golang.org/grpc && \
    go get github.com/golang/protobuf/protoc-gen-go && \
    go get google.golang.org/protobuf/cmd/protoc-gen-go && \
    go get google.golang.org/grpc/cmd/protoc-gen-go-grpc && \
    go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway && \
    go get github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
    
CMD [ "protoc"]
