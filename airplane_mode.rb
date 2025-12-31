# frozen_string_literal: true

require_relative 'packages'
require_relative 'check_rooted'

class AirplaneMode
  def self.name
    'airplane_mode'
  end

  def self.perform(*args)
    input = args[0]
    return unless validate_input(input)

    case input
    when 'on'
      Open3.capture2('adb shell settings put global airplane_mode_on 1')
    when 'off'
      Open3.capture2('adb shell settings put global airplane_mode_on 0')
    end

    if check_rooted
      Open3.capture2('adb shell am broadcast -a android.intent.action.AIRPLANE_MODE')
    else
      puts('Unrooted device requires restart before airplane mode takes effect. Run $ ax reboot.')
    end
  end

  def self.validate_input(input)
    if input.nil? || (input != 'off' && input != 'on')
      puts 'Invalid input. Options are: on off'
      return false
    end
    true
  end

  def self.similar_sounding_commands
    %w[cell wifi]
  end
end
