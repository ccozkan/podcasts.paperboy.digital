class OmniauthController < ApplicationController
  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      redirect_to search_path, notice: "Welcome :^) Let's start subscribing"
    else
      redirect_to new_user_registration_path, alert: @user.errors.full_messages.first
    end
  end
end
