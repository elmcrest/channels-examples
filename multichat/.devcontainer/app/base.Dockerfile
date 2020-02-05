FROM python:3.8-slim-buster

ENV REDIS_HOST "redis"
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED 1

## WAIT-TOOL FOR CHILD-CONTAINERS, USE IN DOCKER-COMPOSE
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.6.0/wait /wait

COPY ./ /app
WORKDIR /app

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    git \
    dumb-init \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && chmod +x /wait \
    && python3 -m pip install --disable-pip-version-check --no-cache-dir -r requirements.txt

ENV DEBIAN_FRONTEND=