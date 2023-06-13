class ApplicationController < ActionController::Base
  def record_page_view
    if response.content_type && response.content_type.start_with?("text/html")
      ActiveAnalytics.record_request(request)
    end
  end
end
