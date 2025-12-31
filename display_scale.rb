# frozen_string_literal: true

require_relative 'packages'
require_relative 'ruby_utils'

class DisplayScale
  def self.name
    'display_scale'
  end

  # Not all devices have these options in system settings, but no reason
  # we can't mimic here
  def self.scales
    {
      'small' => 0.85,
      'default' => 1,
      'large' => 1.1,
      'larger' => 1.2,
      'largest' => 1.30
    }
  end

  def self.perform(*args)
    scale = args[0]
    return unless validate_scale_input(scale)

    if scale == 'default'
      puts 'Resetting density'
      Open3.capture2('adb shell wm density reset')
      return
    end

    compute_and_set_new_density(scale)
  end

  def self.compute_and_set_new_density(scale)
    # must set absolute density. which we can compute from 'physical' density
    scale_float = scales[scale]
    std_out, _status = Open3.capture2('adb shell wm density')

    # find row containing "Physical density: xxxxx"
    match = 'Physical density: '
    physical_density = std_out
                       .as_array
                       .find { |row| row.include?(match) }
                       .sub(match, '')

    new_density = (physical_density.to_f * scale_float).to_i

    puts "Setting new density to #{new_density}"
    Open3.capture2("adb shell wm density #{new_density}")
  end

  def self.similar_sounding_commands
    %w[size display density scale accessibility]
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
