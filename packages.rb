# frozen_string_literal: true

require 'open3'

# returns list of packages as array
def all_packages
  stdout_str, = Open3.capture2('adb shell pm list packages')
  stdout_str.split("\n").map do |row|
    # remove the "package:" part of each line
    row.sub('package:', '')
  end
end
