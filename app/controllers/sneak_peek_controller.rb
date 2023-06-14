class SneakPeekController < ApplicationController

  def sneak_peekable
    status = Feed.find_by(external_id: permitted_params[:feed_external_id])&.episodes.empty?

    render json: { status: status }
  end

  def start_sneak_peeking
    byebug
    FeedPeekerWorker.perform_async # add rss_url

    redirect_to sneaking_and_peeking_path
  end

  def loading
  end

  def show
  end

  private

  def permitted_params
    params.permit(:feed_external_id, :feed_rss_url)
  end
end
