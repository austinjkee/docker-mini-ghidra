# Ghidra Docker Container
These instructions assumes you are using a rootless Docker installation on Ubuntu 24.04 LTS.  Caveat Emptor, they have not been tested with a standard Docker install; the X11 Xauthority hack may break the host's display permissions in standard Docker installations.  Standard Docker users (where you must be root to access the Docker socket) are encouraged to use X11 forwarding over the localhost network instead.

Wayland users are on their own, but display forwarding may actually be easier and safer to implement with a Wayland compositor.

## Building the Image
Within the folder that the contains the Dockerfile: <br/>
```
docker build -t ${USER}/ghidra:11.1.2 .
docker tag ${USER}/ghidra:11.1.2 ${USER}/ghidra:latest
```

## Running the Container
After creating the .env file with the proper contents: <br/>
```
HOSTNAME=<Some hostname if you care about that>
LOCAL_AUTHOR=${USER}
LAB_LOCATION=<Location of your Lab Files>
LAB_SRC_LOCATION=<Location where you want to put your Ghidra Project>
```
run: <br/>
```
docker compose -p eel5934_tuba -f docker-compose.yml run --cap-add=SYS_PTRACE --rm -d lab1_ghidra
```

## Destroying the Container
After you've closed Ghidra, the container may still be running in the background.  You can clean it up with: <br/>
```
docker compose -p eel5934_tuba -f docker-compose.yml down
```

## References
X11 containerized ghidra instance based on [blacktop's docker-ghidra](https://github.com/blacktop/docker-ghidra)
