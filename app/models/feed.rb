class Feed < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  validates_presence_of :external_id
  validates_uniqueness_of :external_id

  after_commit :catch_up_episodes, on: :create

  def catch_up_episodes
    NewEpisodesReceiverWorker.perform_async(self.id)
  end
end
