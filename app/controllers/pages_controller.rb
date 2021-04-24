class PagesController < ApplicationController
  def home
  end

  def search
    @search_results = if search_params[:query]
                        FeedSearcherService.new(search_params[:query]).call
                      else
                        []
                      end
  end

  private

  def search_params
    params.permit(:query)
  end
end
