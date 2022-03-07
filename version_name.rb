# frozen_string_literal: true

class VersionName
  def self.name
    'version_name'
  end

  def self.perform(*args)
    package_name = args[0]
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
