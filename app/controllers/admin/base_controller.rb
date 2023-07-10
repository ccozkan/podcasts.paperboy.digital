class Admin::BaseController < ApplicationController
  before_action :check_if_user_admin?

  private

  def check_if_user_admin?
    redirect_to_root unless current_user.admin?
  end
end
