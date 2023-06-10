class ListenItLaterEpisodesController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def update
    Interaction.toggle_from_listen_it_later!(permitted_params[:episode_id], current_user.id)
    redirect_to request.referer
  end

  def index
    interactions = current_user.listen_it_later_interactions_ordered

    if interactions.present?
      @pagy, @items = pagy(interactions)
    else
      @items = []
    end
  end

  private

  def permitted_params
    params.permit(:episode_id)
  end
end
