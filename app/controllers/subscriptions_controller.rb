class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    feed = Feed.find_or_create_from_params(permitted_params)

    @subscription = Subscription.new(user_id: current_user.id, feed_id: feed.id)
    if @subscription.save
      redirect_to dashboard_path, notice: 'Subscribed!'
    else
      render json: @subscription.errors
    end
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider)
  end
end
