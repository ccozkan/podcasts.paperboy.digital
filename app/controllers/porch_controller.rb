class PorchController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    last_episodes = current_user.porch_episodes
    @listen_it_latereds = current_user.listen_it_later_episode_ids_plucked
    @porch_preference = current_user.preferences["porch_update_interval_mode"] || "zen_mode"

    if last_episodes.present?
      @pagy, @items = pagy(last_episodes)
    else
      @items = []
    end
  end
end
