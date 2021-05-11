class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:github]

  has_many :subscriptions
  has_many :feeds, through: :subscriptions

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirm if user.new_record?
    end
  end

  def send_weekly_digest
    DigestMailer.weekly_digest(self.id)
  end

  def last_weeks_episodes
    Episode.where('published_at > ?', Episode.last_week_time_period[:starting_at])
      .where('published_at < ?', Episode.last_week_time_period[:ending_at])
      .where(feed_id: subscriptions.pluck(:feed_id))
  end
end
