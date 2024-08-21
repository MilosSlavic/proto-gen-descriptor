FROM golang:1.23.0-bullseye as proto-gen-descriptor
ENV GO111MODULE=on
ENV GOPROXY=direct

# Software install and update
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
	protobuf-compiler \
	apt-utils

RUN go env
# Fetch requirements for proto compiler
RUN git clone --depth 1 https://github.com/googleapis/googleapis && \
    git clone --depth 1 https://github.com/googleapis/api-common-protos && \
    git clone --depth 1 https://github.com/protocolbuffers/protobuf
	
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest && \
    go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest && \
    go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest
    
CMD [ "protoc"]
