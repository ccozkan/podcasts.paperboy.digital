require "httparty"

class RequestMakerService
  def initialize(url)
    @url = url
  end

  def call
    result = HTTParty.get(@url)
  rescue StandardError => e
    ServiceResponse.new(payload: nil, error: e)
  else
    ServiceResponse.new(payload: result, error: nil)
  end
end
