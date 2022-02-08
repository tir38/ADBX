# frozen_string_literal: true

require_relative 'wait_for_boot_complete'

class RebootAndWait
  def self.name
    'reboot'
  end

  def self.perform(*_args)
    puts 'Rebooting device. Please wait....'
    Open3.capture2('adb reboot')

    # wait for device to properly boot
    success = wait_for_boot_complete
    if success
      puts 'Done rebooting'
    else
      puts 'Failed to reboot'
    end
  end

  def self.similar_sounding_commands
    []
  end
end
