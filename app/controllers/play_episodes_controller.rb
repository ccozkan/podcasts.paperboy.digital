class PlayEpisodesController < ApplicationController
  layout "player_page"

  def show
    @episode = Episode.find_by(slug: permitted_params[:slug])
  end

  private

  def permitted_params
    params.permit(:slug)
  end
end
