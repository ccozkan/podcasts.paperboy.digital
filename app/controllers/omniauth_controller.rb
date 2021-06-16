class OmniauthController < ApplicationController
  before_action :find_or_create_user

  def github
    handle_omniauth
  end

  def facebook
    handle_omniauth
  end

  def google_oauth2
    handle_omniauth
  end

  private

  def handle_omniauth
    if !@user.persisted?
      redirect_to new_user_registration_path, alert: @user.errors.full_messages.first
    else
      sign_in(:user, @user)
      redirect_to porch_path
    end
  end

  def find_or_create_user
    @user = User.find_or_create_from_provider_data(request.env['omniauth.auth'])
  end
end
