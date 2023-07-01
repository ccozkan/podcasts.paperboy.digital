class PeekFeedsController < ApplicationController
  def show
    @feed = Feed.find_by(external_id: permitted_params[:external_id])
    @items = @feed.episodes.limit(5)
  end

  def peeking
  end

  def peekable
    status = Feed.find_by(external_id: permitted_params[:feed_external_id])&.episodes&.empty?
    render json: { status: status }.to_json
  end

  def start_peeking
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)

    if feed.new_record?
      # feed.only_peek
      feed.save!
    end

    redirect_to peeking_path(external_id: permitted_params[:external_id])
  end

  private

  def permitted_params
    params.permit(:external_id, :feed_rss_url, :name, :pic_url, :rss_url, :provider)
  end

  def find_feed
  end
end
