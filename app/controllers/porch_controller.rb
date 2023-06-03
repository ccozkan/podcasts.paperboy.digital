class PorchController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    last_episodes = current_user.porch_episodes
    if last_episodes.present?
      @pagy, @items = pagy(last_episodes)
    else
      @items = []
    end
  end
end
