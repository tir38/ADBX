# ADB Extensions (ADBX)

ADB commands are not always intuitive. They are also not easy to remember. There is also a lot of bad advice out there. ADBX hopes to solve that.


## Objectives

* Tab completion

	![](tab_completion.gif)

* Command discovery:

	![](command_discovery.gif)

* Package validation

	![](package_validation.gif)

* Combine common operations into single commands
* Detecting rooted device. Some operations can't be performed on non-rooted devices. We'll detect that before running commands
* Encapsulating best practices. There are lots of hacky, half-correct suggestions floating around the internet.


## Progress

| feature | complete |
|:---|:---:|
| tab completion |X|
| command discovery | X |
| package validation | X |
| detect rooted devices | |


## Commands

### `ax add_wifi SSID PASSWORD`

Setup wifi connection. This downloads, installs, and runs [adb-join-wifi](https://github.com/steinwurf/adb-join-wifi)

### `ax airplane_mode on|off`

Sets airplane mode to on or off. Non-rooted devices will require a reboot.

### `ax animation_scale off|0.5|1|1.5|2|5|10|resest`

Sets window animation scale, transition animation scale, and animator duration scale.

### `ax clear_app_data PACKAGE`

Clear all app data, including cache and accepted permissions

### `$ ax demo_mode on|off`

Toggles on or off System UI Demo Mode

### `ax disable_audio AUDIO_STREAM`

Disable device's audio, per stream. Supports all `AudioManager.STREAM_*`:

 * accessibility
 * alarm
 * dtmf
 * music
 * notification
 * ring
 * system
 * voice_call

### `ax display`

Print device's display size and density

### `ax display_scale small|default|large|larger|largest`

Set display scale. Mimics small, default, large, larger, largest options as if set from system Settings app.

### `ax font_scale small|default|large|largest`

Set accessibility font scale. Mimics small, default, large, largest options as if set from system Settings app.

### `ax launch_app PACKAGE`

Launch an app by package name

### `ax layout_bounds show|hide`

Show or hide layout bounds

### `ax list_packages`

List all installed packages (system and non-system)

### `ax max_bright`

Set screen to maximum brightness

### `ax night_mode on|off|auto`

Set device night mode (aka dark mode) on, off, or auto. auto will "automatically switches [night mode] based on the device current location and certain other sensors"

### `ax permissions PACKAGE`

List entire `dumpsys` for a package, with highlighting for <span style="color:green">granted</span> and <span style="color:red">not granted</span> permissions:

![](images/permissiondump.png)

### `ax processor`

Print information on device's processor(s)

### `ax pull_apks PACKAGE LOCATION`

Pull all apks from device to local machine, for a given package. Optionally set location on local machine

### `ax reboot`

Reboot device

### `ax screenshot DESTINATION`

Capture a device screenshot, saving to optional destination, or current directory with timestamp filename.

### `ax settings_app`

Launch system Settings app

### `ax shared_prefs list PACKAGE`

List all shared preferences files within a package

### `ax shared_prefs list PACKAGE FILE_NAME`

Print the content of a single shared preferences file within a single package

### `ax shared_prefs remove PACKAGE FILE_NAME PREF_NAME`

Remove a single value from a shared preferences file

### `ax talkback on|off`

Set Talkback on or off

### `ax uninstall_package PACKAGE`

Uninstalls package by name

### `ax version_name PACKAGE`

Print package's [version name](https://developer.android.com/guide/topics/manifest/manifest-element#vname)

## Configs

ADBX supports a standard `adbx.config` file. ADBX will search up the directory tree from the call point and apply configs as found. See `adbx.config.example`

* `package` - For all commands that require a PACKAGE agumenet, it can be ommited if a package is defined in the config

## Setup

These scripts run as ruby commands. Install latest ruby 3.x. Known working versions:

* Ruby 3.4.1

## Setup tab completion

ADBX relies on Bash Completion 2. Read more about why [here](https://itnext.io/programmable-completion-for-bash-on-macos-f81a0103080b)

#### MacOS pre-steps

1. update to latest Bash (4+): [directions here](https://medium.com/@weibeld/upgrading-bash-on-macos-7138bd1066ba)
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

1. source both `ax` command and completion script. Add to `~/.bashrc`:

```
export PATH=$PATH:path/to/ADBX
source path/to/ADBX/ax_completion.bash
```

2. open new terminal window
3. `$ ax [TAB]`
4. see list of completable actions

## Developer Setup

To ensure code quality, a pre-push hook should be added:

```bash
#!/bin/bash

# Run rubocop before pushing
echo "Running rubocop..."
rubocop

# Check if rubocop passed
if [ $? -ne 0 ]; then
  echo "Rubocop checks failed. Aborting push."
  exit 1
fi

echo "Rubocop checks passed."

# Run tests before pushing
echo "Running tests..."
ruby tests/find_configs_test.rb

# Check if tests passed
if [ $? -ne 0 ]; then
  echo "Tests failed. Aborting push."
  exit 1
fi

echo "All tests passed. Proceeding with push."
```
