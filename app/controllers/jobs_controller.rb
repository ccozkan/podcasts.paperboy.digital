class JobsController < ApplicationController
  def start_job
    FeedPeekerWorker.perform_async(id)
    render json: { message: 'Background process started' }
  end

  def check_job_completion
    status = Sidekiq::Status.complete?(job_id)

    render json: { completed: status }
  end

  def post_params
    permit.params(:job_id)
  end
end
