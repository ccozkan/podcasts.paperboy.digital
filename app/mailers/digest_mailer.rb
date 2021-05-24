class DigestMailer < ApplicationMailer
  def weekly(user_id)
    @user = User.find_by(id: user_id)
    @episodes = @user.last_weeks_episodes.sample(3)
    mail(to: @user.email, subject: 'Your Weekly Podcast Digest')
  end
end
