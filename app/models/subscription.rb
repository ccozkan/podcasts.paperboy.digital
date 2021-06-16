# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  feed_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :feed
  validates_uniqueness_of :user_id, scope: :feed_id
end
