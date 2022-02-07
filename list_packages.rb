require_relative "get_packages"

def list_packages
  packages = get_packages
  puts packages
end
