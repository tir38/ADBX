# frozen_string_literal: true

require 'open3'
require_relative 'find_unknown_value'
require_relative 'packages'

def validate_package(package_name)
  if package_name.nil?
    puts 'Failed to supply package name'
    return false
  end

  packages = all_packages
  return true if packages.include?(package_name)

  possible_packages = find_unknown_value(packages, package_name)
  puts "Failed to find package: #{package_name}"
  unless possible_packages.empty?
    puts 'Did you mean?'
    possible_packages.each do |package|
      puts "   #{package}"
    end
  end
  false
end
