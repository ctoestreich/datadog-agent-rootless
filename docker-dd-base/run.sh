#!/usr/bin/env bash

docker-compose down

./build.sh

docker-compose up