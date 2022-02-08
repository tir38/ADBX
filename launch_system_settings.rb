# frozen_string_literal: true

class LaunchSystemSettings
  def self.name
    'settings_app'
  end

  def self.perform(*_args)
    Open3.capture2('adb shell am start -a android.settings.SETTINGS')
  end

  def self.similar_sounding_commands
    ['start']
  end
end
