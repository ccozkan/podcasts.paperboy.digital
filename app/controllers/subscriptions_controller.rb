class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    feed = Feed.find_or_create_from_data(permitted_params)

    @subscription = Subscription.new(user_id: current_user.id, feed_id: feed.id)

    redirect_to dashboard_path, notice: 'Subscribed!' if @subscription.save!
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider)
  end
end
