# frozen_string_literal: true

require 'open3'
require_relative 'ruby_utils'

class Install
  def self.name
    'install'
  end

  def self.perform(*_args)

    apk_location = args[0]
     return unless file_exists(apk_location)

    Open3.capture2("adb install #{apk_location}")
  end

  def self.similar_sounding_commands
    %w[apk]
  end
end
