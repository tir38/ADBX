# frozen_string_literal: true

require_relative 'validate_package'

class PullApks
  def self.name
    'pull_apks'
  end

  def self.perform(*args)
    cli_package_name = nil
    options = OptionParser.new do |option|
      # find package name from optional
      option.on("--package PACKAGE", "Package name") { |value| cli_package_name = value }
    end

    orderedArguments = options.parse(args)

    package = get_package(cli_package_name)
    return unless validate_package(package)

    stdout_str, = Open3.capture2("adb shell pm path #{package}")

    locations = stdout_str.split("\n").map do |row|
      # remove the "package:" part of each line
      row.sub('package:', '')
    end

    destination = orderedArguments.shift

    puts "Pulling apk(s) for #{package}"
    locations.each do |location|
      Open3.capture2("adb pull #{location} #{destination}")
    end
  end

  def self.similar_sounding_commands
    %w[pull apk apks download get]
  end
end
