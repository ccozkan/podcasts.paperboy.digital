class EpisodesController < ApplicationController
  def show
    @episode = Episode.find_by(slug: params[:slug])
  end
end
