# frozen_string_literal: true

require_relative 'packages'

class Processor
  def self.name
    'processor'
  end

  def self.perform(*_args)
    stdout_str, = Open3.capture2('adb shell cat /proc/cpuinfo')
    puts stdout_str
  end

  def self.similar_sounding_commands
    %w[cpu]
  end
end
