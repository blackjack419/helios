# heliOS

heliOS is a buildroot BR2_EXTERNAL tree used to build and configure an embedded linux operating system that focuses on customizations geared towards IoT telemetry devices. A primary goal is to not reinvent the wheel, but to integrate well-developed tools into something novel and robust for use in the growing realm of edge computing. 

Telemetry devices have two main purposes: 
1. **Monitor** a selection of inputs (i.e. sensors) and report them to a data aggregator (i.e. proxy/server)
2. **Control** a selection of outputs (i.e. relays) either automatically or on-demand.

**Monitor** and **Control** are the two strands of DNA that form the foundation for every and all automation systems. heliOS aims to be the backbone of that foundation and will, if successful, allow anyone to easily create their own complete embedded telemetry device for an endless number of applications. 

Though heliOS is **NOT** an application designed to display and analyze a collection of data, it **IS** designed to move that data from its source to a user applications through standard protocols and over lossy and secure networks - all in an effort to facilitate convenient integration into existing systems.

The design choices for heliOS stem from three main tenents:
1. **Simplicity** - A 10 year old just starting his or her embedded software journey should be able to setup and build his own heliOS device in a few hours. 
2. **Reliability** - The system must expect symptoms of harsh environments (i.e. sudden power loss, serial noise) and take consideration for redundancy in order to ensure robust operation in industrial environments and beyond. 
3. **Futuristic** - Software is a living, breathing thing; if its not growing, then it is dying. Choices must be made to ensure that heliOS is future-proofed for the next decade and beyond by using modern widely accepted embedded design paradigms and limiting dependncies to well-maintained and documented projects.

## Buildroot
---
HeliOS is assembled using the buildroot framework. The master buildroot configuration file for each device will exist in the `configs/` directory. 

Before continuing, it is recommended to familiarize yourself with the buildroot system by perusing the [buildroot manual](https://buildroot.org/downloads/manual/manual.html).

## Building Devices
---
The output of the buildroot system ultimately produces an image which can be used to flash a microprocessor on an embedded device. Each device will hae its own folder to house the entirety of the buildroot build for that particular board/architecture. By default these will be located in the `output/` directory. 

To create a new device:
```
cd output/
mkdir my_device
cd my_device
make -C /path/to/buildroot O=${PWD} BR2_EXTERNAL=/path/to/helios menuconfig
```
subseqeunt calls to make from this directory can omit the options as they are stored in the newly created `.config` file. 


The following commands are described in detail in the buildroot manual, but are listed here for quick reference as they are the most common commands you will use in building and configuring the system. They must be run from the device folder (i.e. `output/my_device/`):

| Command | Effect |
| --- | --- |
| `make menuconfig` | edit master buildroot configuration |
| `make barebox-menuconfig` | edit barebox configuration |
| `make busybox-menuconfig` | edit busybox configuration  |
| `make linux-menuconfig` | edit linux kernel configuration |

The following commands can be used to save the respective configuration file to the appropriate folder in the `board/` directory (this is further explained in the buildroot manual):
| Command | Effect |
| --- | --- |
| `make savedefconfig` | save master buildroot configuration |
| `make barebox-update-defconfig` | save barebox configuration |
| `make busybox-update-config` | save busybox configuration  |
| `make linux-update-defconfig` | save linux kernel configuration |

The locations these files are saved in are adjusted in the master buildroot configuration.

## Barebox (Bootloader)
---
HeliOS uses barebox as the default bootloader. The functionality of barebox is controlled in the environment - a directory of scripts and variable files.

| Environment | Purpose |
| --- | --- |
| `board/<boardname>/barebox.env` | board specific environment |
| `board/common/barebox.env` | HeliOS common environment | 
 
Every barebox board will have the common and board-specific environments merged at compile time. There are several expected directories in this environment which are used to give barebox more advanced functionality:

| Directory | Purpose |
| --- | --- |
| `boot` | boot targets |
| `init` | init scripts and other boot logic |
| `nv` | non-volatile variables used adjust runtime settings |


