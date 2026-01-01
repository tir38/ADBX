# frozen_string_literal: true

require_relative 'validate_package'

class SharedPrefs
  def self.name
    'shared_prefs'
  end

  def self.perform(*args)
    subcommand = args[0]
    return unless validate_sub_command(subcommand)

    package_name = args[1]
    #package_name = get_package(args[1])
    # TODO this  function can't check for package from configs
    # if user leaves off the package then other args are out of orderd
    # and everything breaks, figure out how to fix this
    return unless validate_package(package_name)

    # don't validate these until we need them; they don't need to be supplied for all subcommands
    file_name = args[2]
    pref_name = args[3]

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
