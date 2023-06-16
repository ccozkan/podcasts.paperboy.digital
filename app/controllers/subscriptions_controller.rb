class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    subscribed_feeds = current_user.subscriptions_ordered
    @pagy, @items = pagy(subscribed_feeds)
  end

  def create
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)
    feed.save!
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider)
  end
end
