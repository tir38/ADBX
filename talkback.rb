# frozen_string_literal: true

class Talkback
  def self.name
    'talkback'
  end

  def self.perform(*args)
    input = args[0]
    return unless validate_input(input)

    case input
    when 'on'
      Open3.capture2('adb shell settings put secure enabled_accessibility_services com.google.android.marvin.talkback/com.google.android.marvin.talkback.TalkBackService')
    when 'off'
      Open3.capture2('adb shell settings put secure enabled_accessibility_services com.android.talkback/com.google.android.marvin.talkback.TalkBackService')
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
    ['voice', 'talk', 'talk back']
  end
end
