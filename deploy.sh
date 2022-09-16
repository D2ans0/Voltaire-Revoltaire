#!/bin/bash

# Bot settings
export APP_TOKEN=DISCORD_BOT_TOKEN_HERE
export ENCRYPTION_KEY=$(openssl rand 32 | base64)
export DB_PASSWORD=DB_PASSWORD_HERE0

# Repo settings
export GIT_USER=D2ans0
export GIT_REPO=Voltaire-Revoltaire
export GIT_BRANCH='master'


echo -n Downloading:
echo -n appsettings.json,
wget -N -q -nc 'https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/Voltaire/appsettings.json'
echo -n docker-compose,
wget -N -q -nc 'https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/docker-compose.yml'
echo -n Dockerfile,
wget -N -q -nc 'https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/Dockerfile'
echo -n migration.sql
wget -N -q -nc 'https://raw.githubusercontent.com/D2ans0/Voltaire-Revoltaire/master/migration.sql'
echo

echo Replacing variables...
# set DB pass
sed -i "s/Password=.*;/Password=${DB_PASSWORD};/" appsettings.json
sed -i "s/SA_PASSWORD=.*/SA_PASSWORD=${DB_PASSWORD}/" docker-compose.yml

# set app token and encryption key
sed -i "s/\"discordAppToken\":.*/\"discordAppToken\": \"${APP_TOKEN}\",/" appsettings.json
sed -i "s%\"encryptionKey\":.*%\"encryptionKey\": \"${ENCRYPTION_KEY}\",%" appsettings.json

sed -i "s/USER=.*/USER=${GIT_USER}/" Dockerfile
sed -i "s/REPO=.*/REPO=${GIT_REPO}/" Dockerfile
sed -i "s%BRANCH=.*%BRANCH=${GIT_BRANCH}%" Dockerfile

echo Shutting down existing containers and building images...
docker-compose down;
docker-compose build;

echo Starting containers...
docker-compose up -d

echo 'Waiting for container ready (15s)...'
sleep 15

echo Running migration on database
cat migration.sql | docker exec -i revoltaire_db /opt/mssql-tools/bin/sqlcmd -U sa -P "${DB_PASSWORD}" -i /dev/stdin
