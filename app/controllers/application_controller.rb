class ApplicationController < ActionController::Base
  after_action :record_page_view

  def record_page_view
    if response.content_type&.start_with?("text/html")
      ActiveAnalytics.record_request(request)
    end
  end
end
