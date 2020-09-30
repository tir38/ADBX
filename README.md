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
| tab completion |  X |
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

## Setup tab completion


#### Mac OS pre-steps

1. update to latest Bash: [directions here](https://medium.com/@weibeld/upgrading-bash-on-macos-7138bd1066ba)
2. install `bash-complete@2` [read more](https://itnext.io/programmable-completion-for-bash-on-macos-f81a0103080b)

```
$ brew install bash-completion@2
```

3. update `~/.bashrc` by adding

```
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
```

#### for all machines

1. symlink completion script

```
ln -s [PATH_TO_THIS_REPO]/ax_bash_completion /usr/local/etc/bash_completion.d/ax
```

2. confirm 

```
$ complete -p | grep ax
complete -F _ax ax
```