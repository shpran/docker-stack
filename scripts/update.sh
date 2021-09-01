#!/usr/bin/env bash

ENV_FILE=$(dirname $0)/../.env
NAME=`grep CONTAINER_PREFIX $ENV_FILE | cut -d '=' -f2`

docker exec -it "$NAME"_swagger ./usr/local/bin/cp_swagger.sh;
docker exec -it "$NAME"_swagger ./usr/local/bin/set_server.sh;
