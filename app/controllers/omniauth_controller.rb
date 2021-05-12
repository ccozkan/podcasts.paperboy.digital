class OmniauthController < ApplicationController
  def github
    @user = User.find_or_create_from_provider_data(request.env['omniauth.auth'])

    if !@user.persisted?
      redirect_to new_user_registration_path, alert: @user.errors.full_messages.first
    elsif !@user.new_record?
      sign_in(:user, @user)
      redirect_to search_path, notice: "Welcome :^)"
    elsif @user.new_record?
      sign_in(:user, @user)
      redirect_to search_path, notice: "Welcome :^) Let's start subscribing"
    end
  end
end
