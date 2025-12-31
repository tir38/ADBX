# frozen_string_literal: true

class MaxBright
  def self.name
    'max_bright'
  end

  def self.perform(*_args)
    Open3.capture2('adb shell settings put system screen_brightness 255')
  end

  def self.similar_sounding_commands
    %w[screen display]
  end
end
