require "httparty"

class RequestMakerService
  def initialize(url)
    @url = url
  end

  def call
    result = HTTParty.get(@url)
  rescue StandardError => e
    ServiceResponse.new(error: e)
  else
    ServiceResponse.new(payload: result)
  end
end
