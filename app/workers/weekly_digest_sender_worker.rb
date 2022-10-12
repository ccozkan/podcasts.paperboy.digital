class WeeklyDigestSenderWorker
  include Sidekiq::Worker

  def perform(*args)
    Rails.logger.info('~~ WeeklyDigestSenderWorker has started ~~')
    start_time = Time.now.to_i

    users = User.all

    Rails.logger.info("~~ running for #{users.count} users")

    users.each do |user|
      user.send_weekly_digest
    end

    end_time = Time.now.to_i
    elapsed_time = end_time - start_time
    Rails.logger.info("~~ WeeklyDigestSenderWorker has ended. Took #{elapsed_time} seconds ~~")
  end
end
