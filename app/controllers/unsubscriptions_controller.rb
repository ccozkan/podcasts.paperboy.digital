class UnsubscriptionsController < ApplicationController
  before_action :authenticate_user!, :find_subscription

  def destroy
    @subscription.destroy
    redirect_to dashboard_path
  end

  private

  def find_subscription
    @subscription = Subscription.find_by(user_id: current_user.id, feed_id: permitted_params[:feed_id])
  end

  def permitted_params
    params.permit(:feed_id)
  end
end
