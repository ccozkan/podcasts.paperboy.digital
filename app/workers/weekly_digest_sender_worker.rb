class WeeklyDigestSenderWorker
  include Sidekiq::Worker

  def perform(*args)
    users = User.all
    users.each do |user|
      user.send_weekly_digest
    end
  end
end
