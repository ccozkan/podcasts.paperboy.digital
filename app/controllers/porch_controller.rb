class PorchController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    last_episodes = current_user.porch_episodes
    @listen_it_latereds = current_user.listen_it_latereds_of(last_episodes.pluck(:id))

    if last_episodes.present?
      @pagy, @items = pagy(last_episodes)
    else
      @items = []
    end
  end
end
