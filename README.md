# ctrlx-chirpstack

This is unprofessional hobby project.

## LoRaWAN Network Server for ctrlX

This project aims to support [ISA-95](https://en.wikipedia.org/wiki/ANSI/ISA-95) compliant architectures in Industrial automation and IoT (I-IoT), enabling field deployment of [LoRaWAN](https://en.wikipedia.org/wiki/LoRa) IoT Network Server with help of [ctrlX AUTOMATION](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/) technology. This project provides recipe to build the LoRaWAN server and other neccessary components as snap packages for execution in ctrlX platform.

<img src="https://repository-images.githubusercontent.com/281103347/a11b1300-ca97-11ea-8c3a-207ffbdfcf88" width="250">

## ChirpStack

>[!IMPORTANT]
> This project builds for ChirpStack v3. The ChirpStack web page [www.chirpstack.io](https://www.chirpstack.io) refers to latest version v4 (2023). v3 and v4 differ in programming language, build tools, interfacess and more, making them not backwards compatible: [v4 breaking changes](https://www.chirpstack.io/docs/v4-breaking-changes.html) and [ChirpStack v3 to v4 migration](https://www.chirpstack.io/docs/v3-v4-migration.html)

[ChirpStack](https://www.chirpstack.io) is an open-source LoRaWAN Network Server which can be used to setup LoRaWAN networks. ChirpStack provides a web-interface for the management of gateways, devices and tenants as well to setup data integrations with the major cloud providers, databases and services commonly used for handling device data. ChirpStack provides a gRPC based API that can be used to integrate or extend ChirpStack - [www.chirpstack.io](https://www.chirpstack.io)

This project does not contain `chirpstack-gateway-bridge` application. Thus that must be installed on gateway-side. Consider [ChirpStack OS v3](https://www.chirpstack.io/docs/chirpstack-gateway-os/index.html) as an option.

>[!NOTE]
>This project, as is, does not support most of commercial gateways. Only gateways build on Raspberry Pi with integrated chirpstack-gateway-bridge are supported.

## ctrlX - Secure and Open platform for Automation

**[ctrlX](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/)** is Open, Industry-grade platform for Automation. [ctrlX CORE is certified](https://dc-corp.resource.bosch.com/media/xc/company_1/press/product_information/product_information_2021/august_3/PI__021_21_ctrlX_AUTOMATION_Security_en.pdf) according to [IEC 62443](https://en.wikipedia.org/wiki/IEC_62443) cybersecurity requirements for operational technology (OT) in automation and control systems. Key elements contributing to security are secure boot (TPM 2.0), trusted chain of execution, and isolated snap containers derived from [Ubuntu Core](https://ubuntu.com/core). 

ctrlX CORE control system provides tamper-proof execution environment for applications, making it ideal for field deployments of IoT and Automation - use-cases where the hardware is in someone else's hands. ctrlX provides long term maintenance of platforms and applications with device management and remote management functions in place. System and 3rd party applications are distributed via [ctrlX Store](https://developer.community.boschrexroth.com/t5/Store-and-How-to/bg-p/dcdev_community-dev-blog/label-name/rex_c_Store) also.

<img src="https://apps.boschrexroth.com/microsites/ctrlx-automation/files/ctrlx/Produkte/CORE/DC-AE_ctrlX_CORE_PST3315_02_432x750px.jpg" width="250">

**ctrlX** is ideal platform for field deployment of any Industrial IoT and Automation applications.

>[!TIP]
>**Cloud = your software on someone else's computer**
>
>**IoT = your computer * on someone else's hands**

_*) CPU and MCU considered alike_

## Prerequisites

To use the application, system running [ctrlX OS](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/portfolio/ctrlx-os/) is needed, either 
- [ctrlX CORE](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/portfolio/ctrlx-core/) - Industrial Control System
- [ctrlX WORKS](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/portfolio/ctrlx-works/) COREvirtual - Developpment environment for Windows
- or some custom hardware platform

Following services are needed in ctrlX platform:

- Mosquitto [https://github.com/japikas/ctrlx-mosquitto.git](https://github.com/japikas/ctrlx-mosquitto)
- Postgres [https://github.com/japikas/ctrlx-postgres](https://github.com/japikas/ctrlx-postgres)
- Redis [https://github.com/japikas/ctrlx-redis](https://github.com/japikas/ctrlx-redis)

See build instructions below.

# Build instructions

[ctrlX SDK](https://boschrexroth.github.io/ctrlx-automation-sdk/overview.html) is needed to build snap packages for ctrlX. This project uses latest 2.4 version (2023-12) of the SDK.

Applications are build against **core22**.

## Setup development environment

### Host server / Build environment

Create Ubuntu desktop or server environment 22.04 or newer.
Use one of your choice:
- Physical computer
- Virtual computer
- Cloud server
- [ctrlX WORKS](https://apps.boschrexroth.com/microsites/ctrlx-automation/en/portfolio/ctrlx-works/) for Windows (Ubuntu comes pre-installed in App Build Environment)

>[!WARNING]
> Please bear in mind snaps are build with `--destructive-mode` flag, which means the snapcraft build system may mess up with your host environment. Virtualisation of some kind is recommended for "disposable" host development environment.

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
>GitHub account required.

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
# Deployment & configuration

## Installation

Install packages by uploading from your computer via the Web dashboard of your ctrlX system. 

```
ctrlX Home -> Install an app -> Install from file
```

>[!NOTE]
> Enable execution of unsigned applications in Settings of App management
>```
> ctrlX Home -> Settings -> Apps -> Settings -> Allow installation from unknow source
>```
>
Install prerequisites first: Mosquitto, Postgres and Redis. Install ChiprStack last.

## Configuration

Configuration files of ChirpStack, Mosquitto and Redis are available in ctrlX dashboard. Due to technical reason, configuration and database files of Postgress are currently not available for user.

```
Home -> Manage app data
```

Applications persistent data storage is provided by Rexroth Solutions app. In newer ctrlX OS releases, 2.4 and later, Web Dashboard can be used to edit configuration files as necessary. In older ctrlX OS releases, dashboard does not provide editing function. User can mount the storage with WebDav.

WebDav can be mounted as remote file system for easy of access, or accessed with separate applications like WinSCP, as explained [here](https://boschrexroth.github.io/ctrlx-automation-sdk/persistdata.html#accessing-configuration-files-per-webdav). With web browser, the WebDav resource is accessible in read-only mode.

`https://<device_address>/solutions/webdav/appdata/`

> [!TIP]
> Instructions how to mount WebDav resource as filesystem in [Windows](https://espace.cern.ch/winservices-help/DFS/WebDAV/Pages/UsingWebDAVFromWindows.aspx). [Linux](https://espace.cern.ch/winservices-help/DFS/WebDAV/Pages/UsingDavfsOnOlderLinux.aspx), [Mac](https://espace.cern.ch/winservices-help/DFS/WebDAV/Pages/UsingWebDAVFromMacOSX.aspx).

For instructions how to configure applications, please consult corresponding documentation:

- [ChirpStack v3](https://www.chirpstack.io/docs/v3-documentation.html)
- [Mosquitto](https://mosquitto.org/man/mosquitto-conf-5.html)
- [Redis](https://redis.io/docs/management/config/9)

Postgres is not user configurable in this project at the moment.

### ChirpStack

Configuration of the Network Server is made via the applications own web dashboard, available in port 8080:
```
https://<device_address>:8080
```

### Mosquitto
For test and development use, public access to MQTT server can be enabled as follows:
```
listener 1883 0.0.0.0
allow_anonymous true
```
This is not recommended for production use. Please consider some other access control strategy.

# Support

For commercial support, please contact [Etteplan](https://www.etteplan.com).

`jaakko . ala - paavola @ etteplan . com`
