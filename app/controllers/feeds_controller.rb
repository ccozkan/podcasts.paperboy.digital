class FeedsController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def show
    @feed = Feed.friendly.find_by(permitted_params)
    @query = params[:query]

    episodes = if @query.present?
                 @feed.episodes.where("title ILIKE ?",
                                      "%#{@query}%")
               else
                 @feed.episodes
               end

    if episodes.present?
      @pagy, @items = pagy(episodes)
    else
      @items = []
    end
  end

  def redirect_to_please_wait_page
    redirect_to "/loading"
  end

  private

  def permitted_params
    params.permit(:slug)
  end
end
