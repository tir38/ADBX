require "open3"
require_relative 'validate_package'

class Permissions
  def self.name
    "permissions"
  end

  def self.perform(*args)
    package = args[0]
    return unless validate_package(package)
    base_shell = %Q[adb shell dumpsys package #{package}]
    grep = %Q[ | GREP_COLOR='01;92' egrep --color=always 'granted=true|$' | GREP_COLOR='01;91' egrep -i --color=always 'granted=false|$']
    stdout, _ = Open3.capture2(base_shell + grep)
    puts stdout
  end

  def self.get_similar_sounding_commands
    []
  end
end
