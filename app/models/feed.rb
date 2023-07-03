# == Schema Information
#
# Table name: feeds
#
#  id               :bigint           not null, primary key
#  rss_url          :string
#  pic_url          :string
#  external_id      :string
#  provider         :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  last_check_error :text
#  slug             :string
#
class Feed < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates_presence_of :external_id
  validates_uniqueness_of :external_id
  validates_presence_of :rss_url

  after_create_commit :catch_up_episodes

  extend FriendlyId
  friendly_id :name, use: :slugged

  def catch_up_episodes
    EpisodesReceiverWorker.perform_async(id)
  end

  def user_has_subscribed?(user_id)
    user_ids.include? user_id
  end
end
