class Help
  def self.name
    "help"
  end

  def self.perform(*args)
    print_manual
  end

  def self.get_similar_sounding_commands
    []
  end
end
