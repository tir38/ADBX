# frozen_string_literal: true

require_relative 'validate_package'

class PullApks
  def self.name
    'pull_apks'
  end

  def self.perform(*args)
    package = args[0]
    return unless validate_package(package)

    stdout_str, = Open3.capture2("adb shell pm path #{package}")

    locations = stdout_str.split("\n").map do |row|
      # remove the "package:" part of each line
      row.sub('package:', '')
    end

    destination = args[1]
    locations.each do |location|
      Open3.capture2("adb pull #{location} #{destination}")
    end
  end

  def self.similar_sounding_commands
    %w[pull apk apks download get]
  end
end
