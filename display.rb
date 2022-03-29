# frozen_string_literal: true

require 'open3'

class Display
  def self.name
    'display'
  end

  def self.perform(*_args)
    stdout_str, = Open3.capture2('adb shell wm density')
    puts stdout_str
    stdout_str, = Open3.capture2('adb shell wm size')
    puts stdout_str
  end

  def self.similar_sounding_commands
    %w[screen size density height width pixels dp]
  end
end
