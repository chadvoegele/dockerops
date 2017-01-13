#!/bin/bash
docker-compose run letsencrypt download_certs.sh $@
docker-compose down
exit 0
