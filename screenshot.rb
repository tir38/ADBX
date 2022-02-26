# frozen_string_literal: true

require_relative 'packages'
require 'time'

class Screenshot
  def self.name
    'screenshot'
  end

  def self.perform(*args)
    input_destination = args[0]

    destination = if input_destination.nil? || input_destination.length.zero?
                    "#{Time.now.localtime.strftime('%Y-%m-%d-%H-%M-%S')}.png"
                  else
                    input_destination
                  end

    puts "Saving screenshot to #{destination}"
    Open3.capture2("adb exec-out screencap -p > #{destination}")
  end

  def self.similar_sounding_commands
    %w[image display cap screencap capture]
  end
end
