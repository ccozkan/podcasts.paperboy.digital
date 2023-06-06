# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(50)       default(""), not null
#  uid                    :string(500)      default(""), not null
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github facebook google_oauth2]

  has_many :subscriptions, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :feeds, through: :subscriptions
  has_many :episodes, through: :interactions

  validates_uniqueness_of :email, scope: :provider

  include NewRecordInformable

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

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
    DigestMailer.weekly(id).deliver_later
  end

  def digest_episodes
    Episode.where("published_at > ?", Episode.last_week_time_period[:starting_at]).
      where("published_at < ?", Episode.last_week_time_period[:ending_at]).
      where.not(id: interactions.where(dismissed: true).or(interactions.where.not(listen_it_latered_at: nil)).pluck(:episode_id)).
      where(feed_id: subscriptions.pluck(:feed_id)).
      includes(:feed)
  end

  def porch_episodes
    Episode.where("published_at > ?", Episode.last_week_time_period[:starting_at]).
      where.not(id: interactions.where(dismissed: true).or(interactions.where.not(listen_it_latered_at: nil)).pluck(:episode_id)).
      where(feed_id: subscriptions.pluck(:feed_id)).
      includes(:feed)
  end

  def listen_it_later_episodes
    Episode.
      where(id: interactions.where.not(listen_it_latered_at: nil).order(listen_it_latered_at: :desc).pluck(:episode_id)).
      where(feed_id: subscriptions.pluck(:feed_id)).
      includes(:feed)
  end
end
