require "open3"

def max_bright
  Open3.capture2('adb shell settings put system screen_brightness 255')
end