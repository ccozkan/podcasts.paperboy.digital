class PeekFeedsController < ApplicationController
  before_action :find_feed, only: %i[show start_peeking]

  def show
    @items = @feed.episodes.limit(5)
  end

  def peeking; end

  def peekable
    feed = Feed.find_by(external_id: permitted_params[:external_id])
    status = feed&.healthy.nil? ? false : true

    render json: { status: }.to_json
  end

  def start_peeking
    feed = @feed || Feed.new(permitted_params)

    if feed.new_record?
      feed.save!
    end

    redirect_to peeking_path(external_id: feed.external_id)
  end

  private

  def permitted_params
    params.permit(:external_id, :feed_rss_url, :name, :pic_url, :rss_url, :provider)
  end

  def find_feed
    @feed = Feed.find_by(external_id: permitted_params[:external_id])
  end
end
