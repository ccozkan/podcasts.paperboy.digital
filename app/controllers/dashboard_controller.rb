class DashboardController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!

  def index
    subscribed_feeds = current_user.feeds.paginate(page: params[:page])
    @pagy, @items = pagy(subscribed_feeds)
  end
end
