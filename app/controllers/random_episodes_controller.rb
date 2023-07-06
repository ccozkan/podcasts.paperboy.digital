class RandomEpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    episode = Episode.random_episode(params[:feed_slug])

    redirect_to episode_path(episode)
  end
end
