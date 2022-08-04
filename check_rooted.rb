# frozen_string_literal: true

def check_rooted
  stdout, = Open3.capture2('adb shell whoami')
  if stdout.include?('root')
    true
  else
    puts "This command requries rooted device (or emulator).If this is a\nrooted device, you man need to enable root access by running $ adb root"
    false
  end
end
