# frozen_string_literal: true

class String
  def as_array
    split("\n")
      .reject(&:empty?)
  end
end
