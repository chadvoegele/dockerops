#!/bin/bash
export ENV_NAME="dev"
export ROOT=$(readlink -f $(dirname $0))"/../root"
export LE_ENV="--staging"
export LE_FREQ="* * * * *"
export DOMAIN="dev.chadvoegele.com"
export CODE_DOMAIN="devcode.chadvoegele.com"
export BLOG_DOMAIN="devblog.chadvoegele.com"
export EMAIL="cavoegele@gmail.com"
