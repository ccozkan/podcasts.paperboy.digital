class SearchFeedsController < ApplicationController
  include Pagy::Backend

  def index
    search_results = if permitted_params[:query]
                       retrieve_search_results
                     else
                       []
                     end
    @already_subscribed = current_user.feeds.pluck(:external_id) if current_user
    @pagy, @items = pagy_array(search_results)
  end

  private

  def retrieve_search_results
    # TODO: inform user if something goes wrong, instead of returning []
    service = FeedSearcherService.new(permitted_params[:query]).call
    service.success? ? service.payload : []
  end

  def permitted_params
    params.permit(:query)
  end
end
