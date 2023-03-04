class DigestMailer < ApplicationMailer
  def weekly(user_id)
    user = User.find_by(id: user_id)
    episodes = user.last_weeks_episodes

    @random_episodes = episodes.sample(3)
    @number_of_new_episodes = episodes.size

    unless @number_of_new_episodes.zero?
      mail(to: user.email, subject: "🎧🚲🗞Your Weekly Podcast Digest")
    end
  end
end
