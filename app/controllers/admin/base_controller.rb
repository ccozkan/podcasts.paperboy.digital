# rubocop: disable Rails/ApplicationController
module Admin
  class BaseController < ActionController::Base
    before_action :check_if_user_admin?
    layout "admin/base"

    private

    def check_if_user_admin?
      redirect_to root_path if current_user.nil? || !current_user.admin?
    end
  end
end
# rubocop: enable Rails/ApplicationController
