class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    @query = params[:query]
    subscribed_feeds = if @query
                         current_user.subscriptions_search(@query)
                       else
                         current_user.subscriptions_ordered
                       end
    @pagy, @items = pagy(subscribed_feeds)
  end

  def create
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)
    feed.save!

    @subscription = Subscription.new(user_id: current_user.id, feed_id: feed.id)
    if @subscription.save
      redirect_to request.referer, notice: "Subscribed!🎉"
    else
      render json: @subscription.errors
    end
  end

  private

  def permitted_params
    params.permit(:external_id, :name, :pic_url, :rss_url, :provider)
  end
end
