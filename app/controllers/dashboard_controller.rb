class DashboardController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    subscribed_feeds = current_user.feeds
    @pagy, @items = pagy(subscribed_feeds)
  end
end
