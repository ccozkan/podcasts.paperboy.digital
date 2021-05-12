class PorchController < ApplicationController
  before_action :authenticate_user!

  include Pagy::Backend

  def index
    last_episodes = current_user.last_weeks_episodes
    if last_episodes.blank?
      @items = []
    else
      @pagy, @items = pagy(last_episodes)
    end
  end
end
