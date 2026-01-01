# frozen_string_literal: true

require_relative 'find_config'

class UninstallPackage
  def self.name
    'uninstall_package'
  end

  def self.perform(*args)
    cli_package_name = nil
    options = OptionParser.new do |option|
      # find package name from optional
      option.on("--package PACKAGE", "Package name") { |value| cli_package_name = value }
    end
    options.parse(args)

    package_name = get_package(cli_package_name)
    return unless validate_package(package_name)

    puts "Uninstalling #{package_name}"
    stdout_str, = Open3.capture2("adb uninstall #{package_name}")
    puts stdout_str
  end

  def self.similar_sounding_commands
    %w[remove delete]
  end
end
