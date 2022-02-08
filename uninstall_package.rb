# frozen_string_literal: true

class UninstallPackage
  def self.name
    'uninstall_package'
  end

  def self.perform(*args)
    package_name = args[0]
    return unless validate_package(package_name)

    stdout_str, = Open3.capture2("adb uninstall #{package_name}")
    puts stdout_str
  end

  def self.similar_sounding_commands
    %w[remove delete]
  end
end
