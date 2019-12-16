#!/bin/sh
docker build --pull -t virtualzone/usg-blacklist:amd64 -t virtualzone/usg-blacklist:latest ../.
docker push virtualzone/usg-blacklist:amd64
docker push virtualzone/usg-blacklist:latest
