class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:github, :facebook, :google_oauth2]

  has_many :subscriptions, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :feeds, through: :subscriptions
  has_many :episodes, through: :interactions

  def self.find_or_create_from_provider_data(provider_data)
    user = where(provider: provider_data.provider,
                 uid: provider_data.uid).first_or_initialize
    if user.new_record?
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirm
      user.save!
    end
    user
  end

  def send_weekly_digest
    DigestMailer.weekly(self.id).deliver_later
  end

  def last_weeks_episodes
    Episode.where('published_at > ?', Episode.last_week_time_period[:starting_at])
      .where('published_at < ?', Episode.last_week_time_period[:ending_at])
      .where.not(id: interactions.where(dismissed: true).pluck(:episode_id))
      .where(feed_id: subscriptions.pluck(:feed_id)).includes(:feed)
  end
end
