#!/bin/bash
docker-compose run letsencrypt download_certs.sh $@
docker-compose down --rmi local
exit 0
