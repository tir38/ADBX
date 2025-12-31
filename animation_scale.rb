# frozen_string_literal: true

require_relative 'packages'
require_relative 'ruby_utils'

class AnimationScale
  def self.name
    'animation_scale'
  end

  def self.scales
    {
      'off' => 0.0,
      '0.5' => 0.5,
      '1' => 1.0,
      '1.5' => 1.5,
      '2' => 2.0,
      '5' => 5.0,
      '10' => 10.0,
      'reset' => 1.0
    }
  end

  def self.perform(*args)
    scale = args[0]
    return unless validate_scale_input(scale)

    compute_and_set_new_density(scale)
  end

  def self.compute_and_set_new_density(scale)
    scale_float = scales[scale]
    puts "Setting window animation, transition animation, and animator duration scales to #{scale_float}"
    Open3.capture2("adb shell settings put global window_animation_scale #{scale_float}")
    Open3.capture2("adb shell settings put global transition_animation_scale #{scale_float}")
    Open3.capture2("adb shell settings put global animator_duration_scale #{scale_float}")
  end

  def self.similar_sounding_commands
    %(animation animate scale speed window transition animator duration)
  end

  def self.validate_scale_input(scale)
    if scale.nil? || !scales.key?(scale)
      puts "Unknown scale: #{scale}. Choices are: "
      scales.each_key do |key|
        puts " #{key}"
      end
      return false
    end
    true
  end
end
