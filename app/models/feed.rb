class Feed < ApplicationRecord
  has_many :episodes
  has_many :subscriptions
  has_many :users, through: :subscriptions

  validates_presence_of :external_id
  validates_uniqueness_of :external_id
end
