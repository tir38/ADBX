# frozen_string_literal: true

require 'open3'

class DemoMode
  def self.name
    'demo_mode'
  end

  # map user input arg to adb command argument
  INPUT_MAP = {
    'on' => 'yes',
    'off' => 'no'
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

    case input
    when 'on'
      # if on: enable then enter; then set indivudial status icons
      #   the broadcast reciver does not allow us to replicate the system settings
      #   UI in a single toggle. We need to set each icon's status individually
      Open3.capture2('adb shell settings put global sysui_demo_allowed 1')
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command enter')
      # set wifi to max, and connected
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command network -e wifi show -e level 3 -e fully true')
      # set clock to 2:00 pm
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command clock -e hhmm 1400')
      # hide status icons
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command notifications -e visible false')
      # battery at 100%, not plugged in
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command battery -e plugged false')
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command battery -e level 100')

    when 'off'
      # if off: exit first, then disable.
      #   no need to revert any individual changes made to individual icons
      Open3.capture2('adb shell am broadcast -a com.android.systemui.demo -e command exit')
      Open3.capture2('adb shell settings put global sysui_demo_allowed 0')
    end
  end

  def self.similar_sounding_commands
    %w[demo screen developer]
  end
end
