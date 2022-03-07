# frozen_string_literal: true

class DisableAudio
  def self.name
    'disable_audio'
  end

  # map AudioManager.STREAM_* to int
  # https://developer.android.com/reference/android/media/AudioManager?hl=en#STREAM_ACCESSIBILITY
  def self.streams
    {
      'voice_call' => 0,
      'system' => 1,
      'ring' => 2,
      'music' => 3,
      'alarm' => 4,
      'notification' => 5,
      'dtmf' => 8,
      'accessibility' => 10
    }
  end

  def self.perform(*args)
    stream = args[0]
    return unless validate_stream_input(stream)

    stream_int = streams[stream]

    # Not all streams have '0' as their lowest value. E.g. the 'alarm' stream has a
    # min value of 1. So we can't just set to zero:
    #
    #      adb shell media volume --stream 4 --set 0
    #
    # It's is possible that there is further lack of uniformity across devices and mfg.
    # Instead of reading min value:
    #
    #     adb shell media volume  --stream 4 --get
    #
    # we can instead lower the volume *many* times and assume that we reach the bottom.
    (1..20).to_a.each do
      Open3.capture2("adb shell media volume --stream #{stream_int} --adj lower")
    end
  end

  def self.similar_sounding_commands
    %w[audio sound stream volume]
  end

  def self.validate_stream_input(stream)
    if stream.nil? || !streams.key?(stream)
      puts "Unknown stream: #{stream}. Choices are: "
      streams.keys
             .sort { |a, b| a <=> b }
             .each do |key|
               puts "  #{key}"
             end
      return false
    end
    true
  end
end
