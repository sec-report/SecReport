#!/usr/bin/env zsh

createPassword(){
    cd docker || exit
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
    cd ..
}

run(){
    createPassword
    docker compose up -d
}

stop(){
    docker compose down
}

update(){
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
