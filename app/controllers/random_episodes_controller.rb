class RandomEpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    episode = Episode.random_episode(permitted_params[:feed_slug])
    redirect_to episode_path(episode)
  end

  private

  def permitted_params
    params.permit(:feed_slug)
  end
end
