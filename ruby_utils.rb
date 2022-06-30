# frozen_string_literal: true

class String
  def as_array
    split("\n")
      .reject(&:empty?)
  end
end

def file_exists(path)
  if (File.exist?(path))
    return true
  else
    puts "File does not exist #{path}"
    return false
  end

end
