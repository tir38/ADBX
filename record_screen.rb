require 'open3'

class RecordScreen
  def self.name
    'record_screen'
  end

  def self.perform(*_args)
    remote_location = "/sdcard/#{Time.now.localtime.strftime('%Y-%m-%d-%H-%M-%S')}.mp4"
    # use popen so we can interrupt when done
    Open3.popen2("adb shell screenrecord #{remote_location}")
    puts "Beginning screen recording. Press enter to stop recording..."

    STDIN.gets.chomp
    puts "Done recording"
    Open3.capture2("adb pull #{remote_location}")
  end

  def self.similar_sounding_commands
    %w[record cap capture display video]
  end
end