class ServiceResponse
  class PayloadAndErrorPresenceInconsistency < StandardError; end

  attr_reader :payload, :error

  def initialize(payload: nil, error: nil)
    @payload = payload
    @error = error

    raise PayloadAndErrorPresenceInconsistency if inconsistent?
  end

  def success?
    !!payload && !error
  end

  private

  def inconsistent?
    payload && error || !payload && !error
  end
end
