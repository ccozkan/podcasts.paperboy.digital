class DurationReceiverService
  def initialize(url)
    @url = url
  end

  def call
  rescue StandardError => e
    ServiceResponse.new(error: e)
  else
    ServiceResponse.new(payload: result)
  end
end
