# frozen_string_literal: true

class NightMode
  def self.name
    'night_mode'
  end

  # map user input arg to adb command argument
  INPUT_MAP = {
    'on' => 'yes',
    'off' => 'no',
    'auto' => 'auto'
  }.freeze

  def self.validate_input(input)
    if input.nil? || (!INPUT_MAP.key? input)
      puts "Invalid input. Options are #{INPUT_MAP.keys} "
      return false
    end
    true
  end

  def self.perform(*args)
    input = args[0]
    return unless validate_input(input)

    Open3.capture2("adb shell \"cmd uimode night #{INPUT_MAP[input]}\"")
  end

  def self.similar_sounding_commands
    %w[dark dark_mode night_mode screen]
  end
end
