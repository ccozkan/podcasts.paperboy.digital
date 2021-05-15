class DashboardController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    subscribed_feeds = current_user.feeds
    @pagy, @items = pagy(subscribed_feeds)
  end
end
