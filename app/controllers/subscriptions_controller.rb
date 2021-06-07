class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)
    feed.save!

    @subscription = Subscription.new(user_id: current_user.id, feed_id: feed.id)
    if @subscription.save
      redirect_to dashboard_path, notice: 'Subscribed!'
    else
      render json: @subscription.errors
    end
  end

  def destroy
    subscription = Subscription.find_by(user_id: current_user.id, )
    feed = Feed.find_by(id: permitted_params[:id])
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider)
  end
end
