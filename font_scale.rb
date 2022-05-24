# frozen_string_literal: true

require_relative 'packages'
require 'open3'

class FontScale
  def self.name
    'font_scale'
  end

  # https://developer.android.com/reference/android/provider/Settings.System#FONT_SCALE
  def self.scales
    {
      'small' => 0.85,
      'default' => 1,
      'large' => 1.15,
      'largest' => 1.30
    }
  end

  def self.perform(*args)
    scale = args[0]
    return unless validate_scale_input(scale)

    size_int = scales[scale]

    Open3.capture2("adb shell settings put system font_scale #{size_int}")
  end

  def self.similar_sounding_commands
    %w[size typeface font scale accessibility]
  end

  def self.validate_scale_input(scale)
    if scale.nil? || !scales.key?(scale)
      puts "Unknown scale: #{scale}. Choices are: "
      scales.each_key do |key|
        puts "  #{key}"
      end
      return false
    end
    true
  end
end
