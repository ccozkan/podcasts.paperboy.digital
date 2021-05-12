class SearchFeedsController < ApplicationController
  include Pagy::Backend

  def index
    search_results = if permitted_params[:query]
                       FeedSearcherService.new(permitted_params[:query]).call
                     else
                       []
                     end
    @pagy_a, @items = pagy_array(search_results)
  end

  private

  def permitted_params
    params.permit(:query)
  end
end
