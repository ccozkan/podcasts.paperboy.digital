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
         :recoverable, :rememberable, :confirmable,
         :omniauthable, omniauth_providers: %i[github facebook google_oauth2]

  has_many :subscriptions, dependent: :destroy
  has_many :interactions, dependent: :destroy
  has_many :feeds, through: :subscriptions
  has_many :episodes, through: :interactions

  validates_uniqueness_of :email, case_sensitive: true, scope: :provider
  validates_presence_of :provider

  validate :preference_porch_update_interval_has_valid_value

  AVAILABLE_PROVIDERS = %w(email github facebook google_oauth2).freeze
  validates :provider, inclusion: { in: AVAILABLE_PROVIDERS }

  attribute :provider, default: "email"

  # TODO: move preferebces to lib and use activerecod validations
  attribute :preferences, default: { porch_update_interval_mode: "zen_mode" }

  include NewRecordInformable
  include DeviseTweakable

  class << self
    def find_or_create_from_provider_data(provider_data)
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
  end

  def preference_porch_update_interval_has_valid_value
    pref = preferences["porch_update_interval_mode"]
    return if ["zen_mode", "fresh_daily"].include? pref

    errors.add :preferences, :invalid_porch_update_interval_mode, message: "is invalid preference"
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
    case preferences["porch_update_interval_mode"]
    when "zen_mode" || nil
      Episode.where("published_at > ?", Episode.last_week_time_period[:starting_at]).
        where("published_at < ?", Episode.last_week_time_period[:ending_at]).
        where.not(id: interactions.where(dismissed: true).pluck(:episode_id)).
        where(feed_id: subscriptions.pluck(:feed_id)).
        includes(:feed)
    when "fresh_daily"
      Episode.where("published_at > ?", Episode.last_week_time_period[:starting_at]).
        where.not(id: interactions.where(dismissed: true).pluck(:episode_id)).
        where(feed_id: subscriptions.pluck(:feed_id)).
        includes(:feed)
    end
  end

  def listen_it_later_interactions_ordered
    interactions.
      includes(episode: :feed).
      where.not(listen_it_latered_at: nil).
      order(listen_it_latered_at: :desc)
  end

  def listen_it_later_episode_ids_plucked
    interactions.
      where.not(listen_it_latered_at: nil).
      pluck(:episode_id)
  end

  def subscriptions_ordered
    subscriptions.
      includes(:feed).
      order(created_at: :desc)
  end

  def subscriptions_search(query)
    subscriptions.
      includes(:feed).
      where(feed_id:
              feeds.where("name ILIKE ?",
                          "%#{query}%").pluck(:id))
  end

  def admin?
    email == ENV["ADMIN_USER_EMAIL"]
  end
end
