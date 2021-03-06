#!/bin/sh
############################################################################################
######## Build and run a Docker image for Ground Truth Production Web interactively ########
############################################################################################

## Container name (must be lower case)
read -p "Enter container name: " CONTAINER_NAME

## Image name
read -p "Enter image name: " IMAGE_NAME

## Local path to the directory containing the data
read -p "Enter local data directory: " GTC_WEB_DIR

## Port
read -p "Enter Port: " PORT

## Stop and delete old container (if exists)
OLD="$(docker ps --all --quiet --filter=name="$CONTAINER_NAME")"
if [[ -n "$OLD" ]]; then
  read -p "Stop and remove container with the same name? (y/n): " confirm
  if [[ ${confirm} == [yY] ]]; then
    echo "Old container removed.";
  else
    echo "Aborted.";
    exit;
  fi
  docker stop ${OLD} && docker rm ${OLD}
fi

## Build and start container
docker build -t ${IMAGE_NAME} . && \
docker run \
    -p ${PORT}:8080 \
    -u `id -u root`:`id -g $USER` \
    -v ${GTC_WEB_DIR}:/Data/ \
    --name ${CONTAINER_NAME} \
    -it ${IMAGE_NAME}
