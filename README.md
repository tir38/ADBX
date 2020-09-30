# ADB Extensions (ADBX)

ADB commands are not always intuitive. They are also not easy to remember. There is also a lot of bad advice out there. ADBX hopes to solve that.


## Objectives

* Combining common operations into single scripts
* Tab completion
* Command discovery:

	```
	$ ax restart
	Did you mean "ax reboot"?
	```

* Duplicate behavior on all connected devices. No more "more than one device found"
* Detecting rooted devices. Some operations can't be performed on non-rooted devices. We'll detect that before running commands
* Encapsulating best practices. There are lots of hacky, half-correct suggestions on sites like Stack Overflow


## Progress


|   | completion |
|---|------------|
| tab completion |          |
| command discovery |            |
| multiple devices |            |


## Commands

##### `$ ax max_bright`
	
Sets screen to maximum brightness

##### `$ ax reboot`

Reboots device

##### `$ ax add_wifi SSID PASSWORD`

Setup wifi connection. This downloads, installs, and runs [adb-join-wifi](https://github.com/steinwurf/adb-join-wifi)

## Setup

These scripts run as ruby commands. Install latest ruby 2.7.1

