#!/bin/sh
docker build --pull -t virtualzone/usg-blacklist:arm64 ../.
docker push virtualzone/usg-blacklist:arm64
