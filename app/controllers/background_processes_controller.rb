class BackgroundProcessesController < ApplicationController
  def start_worker
    FeedPeekerWorker.perform_async # add rss_url
    render json: { message: 'Background process started' }
  end

  def check_worker
    status = Sidekiq::Status.complete?(permitted_params[:job_id])

    render json: { completed: status }
  end

  def permitted_params
    permit.params(:job_id, :foo)
  end
end
