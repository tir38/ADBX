def launch_system_settings_app()
  Open3.capture2('adb shell am start -a android.settings.SETTINGS')
end