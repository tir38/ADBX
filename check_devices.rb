# frozen_string_literal: true

require_relative 'wait_for_boot_complete'

def check_devices
  # use -l to get more info on each device
  stdout_str, = Open3.capture2('adb devices -l')

  output_array = stdout_str
                 .split("\n")
                 .reject(&:empty?)
                 .reject { |line| line.include?('List of devices attached') }

  return if more_than_one_device?(output_array)
  return if no_devices?(output_array)
  return if unauthoried_device?(output_array)

  # check for offline device and wait
  if device.include?('offline')
    puts 'Device is currently offline and is likely rebooting. Will try when finished booting'
    return wait_for_boot_complete
  end

  true
end

def unauthoried_device?(output_array)
  # check for unauthorized device
  device = output_array[0]
  if device.include?('unauthorized')
    puts 'Device has not authorized connection to this computer. Be sure to allow USB debugging on device.'
    fingerprint_output,
     = Open3.capture2("awk '{print $1}' < ~/.android/adbkey.pub | openssl base64 -A -d -a | openssl md5 -c")
    puts "This computer's RSA fingerprint is #{fingerprint_output.upcase}"
    return true
  end
  false
end

def no_devices?(output_array)
  if output_array.size.zero?
    puts 'No devices or emulators found. Connect a single device or run a single emulator then retry.'
    return true
  end
  false
end

def more_than_one_device?(output_array)
  # check for multiple devices. e.g.
  #   List of devices attached
  #   emulator-5554	device
  #   emulator-5556	device
  if output_array.size > 1
    puts "More than one device or emulator found. Connect a single device or run a single emulator then retry.\n\n"
    output_array.each do |device|
      device_id =  device.split(' ').first
      # get device name to make it more clear which of these devices is which
      model_name = device
                   .match('model:(\w*)')[0]
      model_name.slice!('model:')
      puts "#{device_id.ljust(20)} #{model_name}"
    end
    puts "\n"
    return true
  end
  false
end
