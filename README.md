Rails5 ready docker image
=========================

This docker-image allows you to run a Rails5 application in a Docker container.
Be sure you have "Docker for Mac/Windowas" installed. [Get it here](https://docs.docker.com/engine/installation/#/on-macos-and-windows)

Then on the command line just type:

```shell
$ docker-compose up -d
```

This will build the application and start it for you.
Forthon feel free to `start` and `stop` the service.

**Note:**
Sometimes when checking the state of the container with `docker-compose ps` you'll see it exited.
In this case try to remove the `server.pid`.

```shell
rm tmp/pids/server.pid
```
