class SearchFeedsController < ApplicationController
  include Pagy::Backend

  def index
    search_results = permitted_params[:query] ? retrieve_search_results : []

    @already_subscribed = current_user.feeds.pluck(:external_id) if current_user
    @pagy, @items = pagy_array(search_results)
  end

  private

  def retrieve_search_results
    service = FeedSearcherService.new(permitted_params[:query]).call

    if service.success?
      service.payload
    else
      render json: "An error occurred during the search"
    end
  end

  def permitted_params
    params.permit(:query)
  end
end
