# frozen_string_literal: true

require 'open3'

TIMEOUT = 60 # seconds
WAIT_CYCLE = 1 # seconds
def wait_for_boot_complete
  Open3.capture2('adb wait-for-device')
  x, = Open3.capture2('adb shell getprop sys.boot_completed')
  count = 0
  until x.start_with?('1')
    print '.'
    if count > TIMEOUT / WAIT_CYCLE
      puts 'Timed out waiting for reboot'
      return false
    end

    sleep WAIT_CYCLE
    count += 1
    x, = Open3.capture2('adb shell getprop sys.boot_completed')
  end
  true
end
