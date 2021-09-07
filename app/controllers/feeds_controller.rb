class FeedsController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def show
    @feed = Feed.friendly.find_by(permitted_params)
    episodes = Episode.where(feed_id: @feed.id).where.not(id: current_user.interactions.where(dismissed: true))

    if episodes.present?
      @pagy, @items = pagy(episodes)
    else
      @items = []
    end
  end

  private

  def permitted_params
    params.permit(:slug)
  end
end
