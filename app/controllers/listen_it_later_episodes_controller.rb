class ListenItLaterEpisodesController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def update
    Interaction.toggle_from_listen_it_later!(permitted_params[:episode_id], current_user.id)
    redirect_to request.referer
  end

  def index
    episodes = current_user.listen_it_later_episodes

    if episodes.present?
      @pagy, @items = pagy(episodes)
    else
      @items = []
    end
  end

  private

  def turbofy
    render turbo_stream:
             turbo_stream.remove("_episode")
  end

  def permitted_params
    params.permit(:episode_id)
  end
end
