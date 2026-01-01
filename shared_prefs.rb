# frozen_string_literal: true

require_relative 'validate_package'
require "optparse"

class SharedPrefs
  def self.name
    'shared_prefs'
  end

  def self.perform(*args)
    cli_package_name = nil
    options = OptionParser.new do |option|
      # find package name from optional
      option.on("--package PACKAGE", "Package name") { |value| cli_package_name = value }
    end

    orderedArguments = options.parse(args)
    subcommand = orderedArguments.shift
    file_name  = orderedArguments.shift
    pref_name  = orderedArguments.shift

    return unless validate_sub_command(subcommand)

    package_name = get_package(cli_package_name)
    return unless validate_package(package_name)

    file_name_present = !file_name.nil? && !file_name.empty?

    case subcommand
    when 'list'
      if file_name_present
        puts "Listing shared prefs content for #{package_name} / #{file_name}:\n\n"
        full_file_path = "/data/data/#{package_name}/shared_prefs/#{file_name}"
        return unless validate_file_exists(package_name, full_file_path, file_name)

        list_contents_of_single_file = lambda { |stdin|
          stdin.write "run-as #{package_name}\n"
          stdin.write "cat #{full_file_path}\n"
        }
        run_as_adb_shell(list_contents_of_single_file)

      else
        puts "Listing all shared prefs files for #{package_name}:\n\n"
        list_all_shared_prefs_files = lambda { |stdin|
          stdin.write "run-as #{package_name}\n"
          stdin.write "ls -al /data/data/#{package_name}/shared_prefs\n"
        }
        run_as_adb_shell(list_all_shared_prefs_files)
      end

    when 'remove'
      if !file_name_present
        puts 'Failed to supply file name'
        return
      end

      full_file_path = "/data/data/#{package_name}/shared_prefs/#{file_name}"
      puts "about to remove package #{package_name}, full file path #{full_file_path}, file name #{file_name}, filename present #{file_name_present}\n\n"
      return unless validate_file_exists(package_name, full_file_path, file_name)
      return unless validate_pref_name(pref_name)

      puts "Removing #{pref_name} from shared prefs #{package_name} / #{file_name}"
      clear_single_shared_pref = lambda { |stdin|
        stdin.write "run-as #{package_name}\n"
        full_file_name = "/data/data/#{package_name}/shared_prefs/#{file_name}"
        regex = "'/^.*name=\"#{pref_name}\".*$/d'"
        stdin.write "sed -i #{regex} #{full_file_name}\n"
      }
      run_as_adb_shell(clear_single_shared_pref)
      puts 'You may need to restart application for changes to take effect.'
    end
  end

  def self.validate_pref_name(pref_name)
    if pref_name.nil? || pref_name.empty?
      puts 'Failed to supply preference name'
      return false
    end
    true
    # TODO: validate that pref is even there before we try to clear it
    # TODO if we don't find it try to scan all of the other pref files in this package
  end

  def self.validate_file_exists(package_name, full_file_path, file_name)
    Open3.pipeline_rw 'adb shell' do |stdin, stdout, _ts|
      stdin.write "run-as #{package_name}\n"
      stdin.write "if [ -e #{full_file_path} ]; then echo true; else echo false; fi \n"
      stdin.close
      out = stdout.read # adb will return true/false as a string with a carriage returnru
      return true unless out.strip == 'false'

      puts "Invalid file name: #{file_name}"
      return false
    end
    Process.waitall
  end

  def self.run_as_adb_shell(lambda)
    Open3.pipeline_rw 'adb shell' do |stdin, stdout, _ts|
      # I can write to adb shell all day long
      lambda.call(stdin)
      stdin.write "exit\n"
      stdin.close
      out = stdout.read
      puts out
    end
    Process.waitall
  end

  def self.validate_sub_command(subcommand)
    valid_subcommands = %w[list remove]
    unless valid_subcommands.include? subcommand
      puts "Unknown subcommand: #{subcommand}. Choices are: "
      valid_subcommands.each do |x|
        puts "  #{x}"
      end
      return false
    end
    true
  end

  def self.similar_sounding_commands
    %w[preferences share shared list remove delete]
  end
end
