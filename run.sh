#!/usr/bin/env bash

downloadSelf(){
    wget https://raw.githubusercontent.com/sec-report/SecReport/main/run.sh
    chmod +x run.sh
}

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

exec() {
    if [ "$1" = "addUser" ]
    then
        docker compose exec sec-report /sec_report $1 $2 $3 $4 $5 $6 $7
    elif [ "$1" = "changeUserPassword" ]
    then
        docker compose exec sec-report /sec_report $1 $2 $3 $4 $5
    elif [ "$1" = "setBasisLogin" ]
    then
        docker compose exec sec-report /sec_report $1 $2 $3
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
    downloadSelf
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
elif [ "$1" = "exec" ]
then
    exec $2 $3 $4 $5 $6 $7 $8
    exit
fi

run
