class LaunchSystemSettings
  def self.name
    "settings_app"
  end

  def self.perform(*args)
    Open3.capture2('adb shell am start -a android.settings.SETTINGS')
  end

  def self.get_similar_sounding_commands
    []
  end
end
