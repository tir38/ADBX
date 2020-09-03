require "down"
require "fileutils"
require "open3"

def add_wifi_no_root(ssid, password)
  puts "Adding wifi: #{ssid}"
  puts "Downloading and installing adb-join-wifi app..."

  # download and keep original file name
  tempfile = Down.download("https://github.com/steinwurf/adb-join-wifi/releases/download/1.0.1/adb-join-wifi.apk")
  FileUtils.mv(tempfile.path, "./#{tempfile.original_filename}")

  Open3.capture2('adb install adb-join-wifi.apk')
  Open3.capture2("adb shell am start -n com.steinwurf.adbjoinwifi/.MainActivity -e ssid #{ssid} -e password_type WPA -e password #{password}")
  Open3.capture2('rm adb-join-wifi.apk')

  # wait for 'am start' to finish before uninstalling apk
  sleep(10)
  Open3.capture2('adb uninstall com.steinwurf.adbjoinwifi')
end
