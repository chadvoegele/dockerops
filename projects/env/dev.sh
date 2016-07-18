#!/bin/bash
export ENV_NAME="dev"
export ROOT=$(readlink -f $(dirname $0))"/../root"
export LE_ENV="--staging"
export LE_FREQ="* * * * *"
export DOMAIN="dev.chadvoegele.com"
export GIT_DOMAIN="devgit.chadvoegele.com"
export EMAIL="cavoegele@gmail.com"
