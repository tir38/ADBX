# frozen_string_literal: true

require 'open3'
require_relative 'validate_package'

class Permissions
  def self.name
    'permissions'
  end

  def self.perform(*args)
    package = args[0]
    return unless validate_package(package)

    base_shell = %(adb shell dumpsys package #{package})
    grep_granted = %( | GREP_COLOR='01;92' egrep --color=always 'granted=true|$')
    grep_rejected = %( | GREP_COLOR='01;91' egrep -i --color=always 'granted=false|$')
    stdout, = Open3.capture2(base_shell + grep_granted + grep_rejected)
    puts stdout
  end

  def self.similar_sounding_commands; end
end
