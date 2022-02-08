# frozen_string_literal: true

class Help
  def self.name
    'help'
  end

  def self.perform(*_args)
    print_manual
  end

  def self.similar_sounding_commands
    ['info']
  end
end
