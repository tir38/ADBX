# frozen_string_literal: true

def check_rooted
  stdout, = Open3.capture2('adb shell whoami')
  if stdout.include?('root')
    true
  else
    puts 'Detected non-root user. If this is a rooted device, you may need to enable root access by running $ adb root.'
    false
  end
end
