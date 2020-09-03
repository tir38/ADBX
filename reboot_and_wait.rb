def reboot_and_wait
  puts "Rebooting device.... plz wait"
  puts `adb reboot`

  # wait for device to properly boot
  puts `./wait_for_boot_complete.sh`
  puts "Done rebooting"
end
