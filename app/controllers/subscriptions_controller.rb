class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)

    unless feed.save
      render json: feed.errors
      return
    end

    @subscription = Subscription.new(user_id: current_user.id, feed_id: feed.id)
    if @subscription.save
      redirect_to subscriptions_path
    else
      render json: @subscription.errors
    end
  end

  def destroy
    feed = Feed.find_by(id: permitted_params[:id])
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider, :id)
  end
end
