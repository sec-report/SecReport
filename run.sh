#!/usr/bin/env bash

downloadDockerCompose(){
     if [ ! -f "docker-compose.yml" ]; then
         wget https://raw.githubusercontent.com/sec-report/SecReport/main/docker-compose.yml
     fi
}

createPassword(){
    if [ ! -f "mongodb_password.txt" ]; then
        echo -n $(uuidgen |sed 's/-//g') > mongodb_password.txt
    fi
    if [ ! -f "redis_password.txt" ]; then
        echo -n $(uuidgen |sed 's/-//g') > redis_password.txt
    fi
    if [ ! -f "s3_password.txt" ]; then
        echo -n $(uuidgen |sed 's/-//g') > s3_password.txt
    fi
    if [ ! -f "editor_sync_password.txt" ]; then
        echo -n $(uuidgen |sed 's/-//g') > editor_sync_password.txt
    fi
}

run(){
    downloadDockerCompose
    createPassword
    docker compose up -d
}

stop(){
    docker compose down
}

update(){
    if [ -f "docker-compose.yml" ]; then
         rm docker-compose.yml
         downloadDockerCompose
    fi
    docker compose pull
}

if [ "$1" = "stop" ]
then
    stop
    exit
elif [ "$1" = "update" ]
then
    update
    exit
fi

run
