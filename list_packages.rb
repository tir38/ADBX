require "open3"

def list_packages
  stdout_str, _ = Open3.capture2('adb shell pm list packages')
  puts stdout_str
end