class DismissEpisodesController < ApplicationController
  before_action :authenticate_user!

  def update
    Interaction.dismiss_an_episode(permitted_params[:episode_id], current_user.id)
    redirect_to request.referrer
  end

  private

  def permitted_params
    params.permit(:episode_id)
  end
end
