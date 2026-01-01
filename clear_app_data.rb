# frozen_string_literal: true

require_relative 'packages'
require_relative 'find_config'

class ClearAppData
  def self.name
    'clear_app_data'
  end

  def self.perform(*args)
    package_name = get_package(args[0])
    return unless validate_package(package_name)

    Open3.capture2("adb shell pm clear #{package_name}")
  end

  def self.similar_sounding_commands
    %w[remove delete cache]
  end
end
