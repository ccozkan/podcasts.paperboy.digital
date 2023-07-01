class PeekFeedsController < ApplicationController
  def show
  end

  def peeking
  end

  def peekable
    status = Feed.find_by(external_id: permitted_params[:feed_external_id])&.episodes&.empty?
    sleep 5
    render json: { status: status }.to_json
  end
end
