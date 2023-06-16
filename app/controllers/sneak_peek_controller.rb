class SneakPeekController < ApplicationController

  def sneak_peekable
    status = Feed.find_by(external_id: permitted_params[:feed_external_id])&.episodes.empty?


    sleep 10
    render json: { status: status }.to_json
  end

  def start_sneak_peeking
    feed = Feed.find_by(external_id: permitted_params[:external_id]) || Feed.new(permitted_params)
    feed.save!

    redirect_to sneaking_and_peeking_path(external_id: permitted_params[:external_id])
  end

  def loading
  end

  def show
    redirect_to feed_path(Feed.find_by(external_id: permitted_params[:external_id]).slug)
  end

  private

  def permitted_params
    params.permit(:external_id, :feed_rss_url, :name, :pic_url, :rss_url, :provider)
  end
end
