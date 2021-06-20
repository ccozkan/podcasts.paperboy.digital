class SearchFeedsController < ApplicationController
  include Pagy::Backend

  def index
    search_results = if permitted_params[:query]
                       FeedSearcherService.new(permitted_params[:query]).call
                     else
                       []
                     end
    @already_subscribed = current_user.feeds.pluck(:external_id) if current_user
    @pagy, @items = pagy_array(search_results)
  end

  private

  def permitted_params
    params.permit(:query)
  end
end
