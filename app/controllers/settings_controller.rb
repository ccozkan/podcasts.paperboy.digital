class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
  end

  private

  def post_params
    params.permit(:porch_update_mode)
  end
end
