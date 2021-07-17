require "open3"

def uninstall_package(package_name)
  stdout_str, _ = Open3.capture2("adb uninstall #{package_name}")
  puts stdout_str
end