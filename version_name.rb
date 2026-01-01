# frozen_string_literal: true

class VersionName
  def self.name
    'version_name'
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

    stdout_str, = Open3.capture2("adb shell dumpsys package #{package_name} | grep versionName")
    name = stdout_str
           .strip # remove leading whitespace
           .delete_prefix('versionName=') # remove versionName=
    puts name
  end

  def self.similar_sounding_commands
    %w[version name]
  end
end
