# frozen_string_literal: true

require_relative 'poke_system_props'

class LayoutBounds
  def self.name
    'layout_bounds'
  end

  def self.perform(*args)
    input = args[0]
    if input != 'show' && input != 'hide'
      puts 'Unknown argument; valid arguments are show|hide'
      return
    end

    if input == 'show'
      Open3.capture2('adb shell setprop debug.layout true')
    else
      Open3.capture2('adb shell setprop debug.layout false')
    end
    poke_system_props
  end

  def self.similar_sounding_commands
    %w[bounds layout]
  end
end
