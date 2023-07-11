class EpisodesController < ApplicationController
  def show
    @episode = Episode.find_by(slug: params[:slug])
    interaction = Interaction.find_by(user_id: current_user.id, episode_id: @episode.id) if current_user
    if interaction
      @listen_it_latered = interaction.listen_it_latered_at?
      @liked = interaction.liked_at?
    else
      @listen_it_latered = false
      @liked = false
    end
  end
end
