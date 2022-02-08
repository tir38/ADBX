require_relative "get_packages"

class ListPackages
  def self.name
    "list_packages"
  end

  def self.perform(*args)
    packages = get_packages
    puts packages
  end

  def self.get_similar_sounding_commands
    []
  end
end
