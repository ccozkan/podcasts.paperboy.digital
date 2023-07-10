module Admin
  class BaseController < ApplicationController
    before_action :check_if_user_admin?

    private

    def check_if_user_admin?
      redirect_to root_path if current_user.nil? || !current_user.admin?
    end
  end
end
