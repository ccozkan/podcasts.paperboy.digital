class StarEpisodesController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def update
    Interaction.star_or_unstar_an_episode!(permitted_params[:episode_id], current_user.id)
    redirect_to request.referer
  end

  def index
    starred_episodes = current_user.starred_episodes

    if starred_episodes.present?
      @pagy, @items = pagy(starred_episodes)
    else
      @items = []
    end
  end

  private

  def permitted_params
    params.permit(:episode_id)
  end
end
