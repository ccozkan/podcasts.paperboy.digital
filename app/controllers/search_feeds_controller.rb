class SearchFeedsController < ApplicationController
  include Pagy::Backend

  def index
    @categories = BrowseSearchController::CATEGORY_MAP
    @query = permitted_params[:query]
    return unless @query

    search_results = retrieve_search_results(@query)
    if search_results.empty?
      @no_results_found = true
    else
      @already_subscribed = current_user.feeds.pluck(:external_id) if current_user
      @pagy, @items = pagy_array(search_results)
    end
  end

  private

  def retrieve_search_results(param)
    service = FeedSearcherService.new(param).call

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
