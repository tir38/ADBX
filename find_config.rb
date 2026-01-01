#!/usr/bin/env ruby
# frozen_string_literal: true

require "pathname"

CONFIG_FILENAME = "adbx.config"

def find_config_file(start_dir)
  dir = Pathname.new(start_dir).expand_path

  loop do
    candidate = dir / CONFIG_FILENAME
    return candidate if candidate.file?

    break if dir.root?

    dir = dir.parent
  end

  nil
end

def parse_config(path)
  config = {}

  path.read.each_line do |line|
    line = line.strip
    next if line.empty? || line.start_with?("#")
    next unless line.include?("=")

    key, value = line.split("=", 2).map(&:strip)
    next if key.empty?

    config[key] = value.to_s
  end

  config
rescue StandardError
  {}
end

def find_package_in_config
  config_path = find_config_file(Dir.pwd)
  return "" unless config_path

  config = parse_config(config_path)
  config.fetch("package", "")
end

# if user entered a package when invoking command then return it, otherwise search in config
def get_package(cli_package_name)
  return cli_package_name unless cli_package_name.nil? || cli_package_name.empty?

  return find_package_in_config
end
