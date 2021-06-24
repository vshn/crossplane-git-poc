#!/bin/bash

sudo docker run --detach \
  --publish 8443:443 --publish 8081:80 --publish 2222:22 \
  --name gitlab \
  --volume $(pwd)/data/config:/etc/gitlab \
  --volume $(pwd)/data/logs:/var/log/gitlab \
  --volume $(pwd)/data/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest