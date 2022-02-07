require_relative 'wait_for_boot_complete'

def reboot_and_wait
  puts "Rebooting device. Please wait...."
  Open3.capture2("adb reboot")

  # wait for device to properly boot
  success = wait_for_boot_complete
  if success
    puts "Done rebooting"
  else
    puts "Failed to reboot"
  end
end
