class EpisodeDurationReceiverService
  def initialize(audio_url)
    @url = audio_url
  end

  def call
    result = get_duration
    byebug

  rescue StandardError => e
    ServiceResponse.new(error: e)
  else
    ServiceResponse.new(payload: result)
  end

  private

  def get_duration
    cmd = "ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 #{@url}"
    system(cmd)
  end
end
