# frozen_string_literal: true

require 'open3'

def poke_system_props
  # Any time we setprops, we have to poke the system to get change to register
  # 1599295570 maps to SYSPROPS_TRANSACTION
  # See how the system dev options app does it:
  # https://android.googlesource.com/platform/frameworks/base/+/master/packages/SettingsLib/src/com/android/settingslib/development/SystemPropPoker.java
  Open3.capture2('adb shell service call activity 1599295570')
end
