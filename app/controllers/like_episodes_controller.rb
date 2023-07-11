class LikeEpisodesController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def update
    Interaction.toggle_from_like!(permitted_params[:episode_id], current_user.id)
    redirect_to request.referer
  end

  def index
    interactions = current_user.like_interactions_ordered
    @override_liked = true
    @dont_show_litl = true

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
