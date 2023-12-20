# ctrlx-chirpstack
LoRaWAN Network server for [ctrlX AUTOMATION](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/).

>[ChirpStack](https://www.chirpstack.io) is an open-source LoRaWAN Network Server which can be used to setup LoRaWAN networks. ChirpStack provides a web-interface for the management of gateways, devices and tenants as well to setup data integrations with the major cloud providers, databases and services commonly used for handling device data. ChirpStack provides a gRPC based API that can be used to integrate or extend ChirpStack.

>[!NOTE]
> This project builds for Chirpstack v3. The Chirpstack web page [www.chirpstack.io](https://www.chirpstack.io) refers to latest version (v4).

## Pre-requisities

Following services are needed in ctrlX platform:

- Mosquitto [https://github.com/japikas/ctrlx-mosquitto.git](https://github.com/japikas/ctrlx-mosquitto)
- Redis [https://github.com/japikas/ctrlx-redis](https://github.com/japikas/ctrlx-redis)
- Postgres [https://github.com/japikas/ctrlx-postgres](https://github.com/japikas/ctrlx-postgres)

See build instructions below.

# Build instructions

## ctrlX 2.4 development environment & Application Build

## Setup

### Host server

Create Ubuntu server or desktop environment 22.04 or newer.
Use one of you choice:
- Physical computer
- Virtual computer
- Cloud server
- [ctrlX WORKS](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/portfolio/ctrlx-works/) for Windows (Ubuntu comes pre-installed in App Build Environment)

>[!WARNING]
> Please bear in mind snaps are build with `--destructive-mode` flag, which means the snapcraft build system may mess up with your host environment. Use of virtualisation of some type is recommended.

### ctrlX SDK installation
```
$ git clone https://github.com/boschrexroth/ctrlx-automation-sdk.git
$ cd ctrlx-automation-sdk/scripts
$ chmod a+rx *.sh
$ sudo apt install jq
$ ./clone-install-sdk.sh 
    Version (release): 2.4.0
    Branch name:   2.4.0
    Install aarch64 libs: y
```
**Tools installation:**
```
$ sudo apt install npm
```
**Ssh keys for GitHub**

This is needed to access to Chirpstack sources. 
>[!IMPORTANT]
>Github account needed.

```
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
```
Add keys (copy paste from .ssh/id_ed25519.pub) via GitHub web UI:  Account -> Settings -> SSH & GPG


## Build applications

**Mosquitto**
```
$ git clone https://github.com/japikas/ctrlx-mosquitto.git
$ cd ctrlx-mosquitto/
$ snapcraft --destructive-mode
$ cd ..
```
**Redis**
```
$ git clone https://github.com/japikas/ctrlx-redis.git
$ cd ctrlx-redis/
$ snapcraft --destructive-mode
$ cd ..
```
**Postgres**
```
$ git clone https://github.com/japikas/ctrlx-postgres.git
$ cd ctrlx-postgres/
$ snapcraft --destructive-mode
$ cd ..
```
**Chirpstack**
```
$ git clone https://github.com/japikas/ctrlx-chirpstack
$ cd ctrlx-chirpstack/
$ snapcraft --destructive-mode
$ cd ..
```
