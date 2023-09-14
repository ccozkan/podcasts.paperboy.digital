class ServiceResponse < Data.define(:error, :payload)
  def success?
    !error
  end
end
