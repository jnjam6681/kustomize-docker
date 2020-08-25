FROM ubuntu:18.04 as base

ENV KUSTOMIZE_VERSION v3.8.1
WORKDIR /app

RUN apt-get update && apt-get install -y wget \
    && wget https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz \
    && tar xzf kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz

#############################

FROM alpine:3.12.0

RUN apk add --no-cache git curl

COPY --from=base /app/kustomize /usr/local/bin/kustomize

CMD ["kustomize"]