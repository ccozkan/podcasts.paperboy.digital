class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :subscriptions
  has_many :feeds, through: :subscriptions

  def send_weekly_digest
    DigestMailer.weekly_digest(self.id)
  end

  def last_weeks_episodes
    Episode.where('published_at > ?', Episode.last_week_time_period[:starting_at])
      .where('published_at < ?', Episode.last_week_time_period[:ending_at])
      .where(feed_id: subscriptions.pluck(:feed_id))
  end
end
