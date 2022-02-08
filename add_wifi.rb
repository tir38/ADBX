# frozen_string_literal: true

require 'down'
require 'fileutils'
require 'open3'

class AddWifi
  def self.name
    'add_wifi'
  end

  def self.perform(ssid, password)
    puts "Adding wifi: #{ssid}"

    # check for existing adb-join-wifi app
    stdout_str = Open3.capture2('adb shell pm list packages | grep com.steinwurf.adbjoinwifi')

    if stdout_str.include? 'com.steinwurf.adbjoinwifi'
      puts 'adb-join-wifi already installed'
    else
      puts 'Downloading and installing adb-join-wifi app...'

      # download and keep original file name
      tempfile = Down.download('https://github.com/steinwurf/adb-join-wifi/releases/download/1.0.1/adb-join-wifi.apk')
      FileUtils.mv(tempfile.path, "./#{tempfile.original_filename}")

      Open3.capture2('adb install adb-join-wifi.apk')
    end

    Open3.capture2('adb shell am start '\
      '-n com.steinwurf.adbjoinwifi/.MainActivity '\
      "-e ssid #{ssid} "\
      '-e password_type WPA '\
      "-e password #{password}")
    Open3.capture2('rm -f adb-join-wifi.apk')

    sleep(10)
    # force stop app so that if we call this method again we don't get a "Warning: Activity not started, its current
    # task has been brought to the front" error
    Open3.capture2('adb shell am force-stop com.steinwurf.adbjoinwifi')

    # NOTE: can't uninstall or OS will forget the wifi we just added since that wifi is "tied" to this app/package
    # Open3.capture2('adb uninstall com.steinwurf.adbjoinwifi')
  end

  def self.similar_sounding_commands
    []
  end
end
