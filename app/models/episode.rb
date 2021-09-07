# == Schema Information
#
# Table name: episodes
#
#  id           :bigint           not null, primary key
#  external_id  :string
#  audio_url    :string
#  title        :string
#  published_at :datetime
#  feed_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string
#
class Episode < ApplicationRecord
  belongs_to :feed

  validates_presence_of :external_id
  validates_uniqueness_of :external_id
  validates_presence_of :audio_url

  has_many :interactions, dependent: :destroy

  default_scope { order(published_at: :desc) }

  extend FriendlyId
  friendly_id :title, use: :slugged

  def self.this_week_time_period
    last_week = self.last_week_time_period
    {
      starting_at: last_week[:starting_at] + 7.days,
      ending_at: last_week[:ending_at] + 7.days
    }
  end

  def self.last_week_time_period
    starting_at = Date.tomorrow.prev_occurring(:wednesday).beginning_of_day - 7.days + 12.hours
    {
      starting_at: starting_at,
      ending_at: starting_at + 7.days
    }
  end
end
