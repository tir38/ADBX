# frozen_string_literal: true

require_relative 'packages'

class ListPackages
  def self.name
    'list_packages'
  end

  def self.perform(*_args)
    packages = all_packages
    puts packages
  end

  def self.similar_sounding_commands
    []
  end
end
