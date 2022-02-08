require "open3"

class MaxBright
  def self.name
    "max_bright"
  end

  def self.perform(*args)
    Open3.capture2('adb shell settings put system screen_brightness 255')
  end

  def self.get_similar_sounding_commands
    []
  end
end
