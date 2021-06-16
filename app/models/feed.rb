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
#
class Feed < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates_presence_of :external_id
  validates_uniqueness_of :external_id
  validates_presence_of :rss_url

  after_commit :catch_up_episodes, on: :create

  def catch_up_episodes
    NewEpisodesReceiverWorker.perform_async(self.id)
  end
end
