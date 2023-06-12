class EpisodesController < ApplicationController
  def show
    @episode = Episode.find_by(slug: permitted_params[:slug])
  end

  def permitted_params
    params.permit(:slug)
  end
end
