class DismissEpisodesController < ApplicationController
  before_action :authenticate_user!

  def update
    Interaction.dismiss!(permitted_params[:episode_id], current_user.id)
    turbofy
  end

  private

  def turbofy
    render turbo_stream:
             turbo_stream.remove("dismissable_episode")
  end

  def permitted_params
    params.permit(:episode_id)
  end
end
