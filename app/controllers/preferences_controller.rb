class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def update
    porch_update_interval_mode_param = permitted_params[:porch_update_interval_mode]
    if porch_update_interval_mode_param
      current_user.preferences["porch_update_interval_mode"] = porch_update_interval_mode_param
      current_user.save!

      redirect_to request.referer, notice: "Saved! 💾"
    end
  end

  private

  def permitted_params
    params.permit(:porch_update_interval_mode)
  end
end
