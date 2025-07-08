#!/usr/bin/env bash
set -o allexport
source .env            # .env 전체를 쉘 환경 변수로 export
set +o allexport

docker stack deploy -c docker-stack.yml textneckhub