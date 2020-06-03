# Ground Truth Production Web Docker
Docker image for [Ground Truth Production Web](https://github.com/OCR4all/ground_truth_production)

## Getting Started

These instructions will get you a [Docker container](https://www.docker.com/what-container) that runs Ground Truth Production Web

### Prerequisites

[Docker](https://www.docker.com) (for installation instructions see the [Official Installation Guide](https://docs.docker.com/install/))

### Installing

#### Get the Docker Image
From Docker Hub:
* Execute the following command ```docker pull maxnth/gtcweb```

or

From Source:
* Clone this repository first and enter the cloned directory with a command line tool.

* Execute the following command inside the directory: ``` docker build -t <IMAGE_NAME> . ``` 

__or__

Use `build.sh` or `build_interactive.sh` to build from source:
* Configure `build.sh` with your configuration and run `sh build.sh`.

    __or__

* Run `sh build_interactive.sh` and follow the steps in the terminal accordingly.
* Both steps will automatically build the image from source and start the container. When using this some following steps can be ignored.

#### Initialize Container
With the help of the image a container can now be created with the following command:
```
docker run \
    -p 8080:8080 \
    -u `id -u root`:`id -g $USER` \
    --name <CONTAINER_NAME> \
    -it <IMAGE_NAME>
```

Explanation of variables used above:
* `<CONTAINER_NAME>` - Name of the Docker container e.g. larex
* `<IMAGE_NAME>` - Name of the Docker image e.g. maxnth/larex

The container will be started by default after executing the `docker run` command.

If you want to start the container again later use `docker ps -a` to list all available containers with their Container IDs and then use `docker start <CONTAINER_NAME>` to start the desired container.

You can now access the project via following URL: http://localhost:8080/GTC_Web/

### Updating
#### From Docker Hub:

Updating the image can easily be done via the docker hub if the image has been previously pulled from the docker hub.

The following command will update the image:
```
docker pull maxnth/gtcweb
```

#### From Source:

To update the source code of the project you currently need to reinstall the image.

This can be achieved with executing the following command first:
```
docker image rm <IMAGE_NAME>
```
Afterwards you can follow the installation guide above as it is a new clean installation.
