class DismissEpisodesController < ApplicationController
  before_action :authenticate_user!

  authenticate_user!
  def update
    Interaction.dismiss!(permitted_params[:episode_id], current_user.id)
    turbofied_remove && return if request_is_from_porch?

    redirect_to request.referer
  end

  private

  def turbofied_remove
    render turbo_stream:
             turbo_stream.replace("interactable_porch_episode_#{permitted_params[:episode_id]}")
  end

  def request_is_from_porch?
    request.referer == porch_url
  end

  def permitted_params
    params.permit(:episode_id)
  end
end
