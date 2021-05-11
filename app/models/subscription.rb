class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates_uniqueness_of :user_id, scope: :feed_id
end
