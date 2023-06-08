class FeedsController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def show
    @feed = Feed.friendly.find_by(permitted_params)
    episodes = current_user.undismissed_episodes(@feed.id)

    if episodes.present?
      @pagy, @items = pagy(episodes)
    else
      @items = []
    end
  end

  def redirect_to_please_wait_page
    redirect_to '/loading'
  end

  private

  def permitted_params
    params.permit(:slug)
  end
end
