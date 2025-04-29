#!/bin/bash

export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
docker run -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres
