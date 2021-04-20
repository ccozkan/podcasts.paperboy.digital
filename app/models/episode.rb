class Episode < ApplicationRecord
  belongs_to :feed

  validates_presence_of :external_id
  validates_uniqueness_of :external_id

  def self.this_week_time_period
    last_week = self.last_week_time_period
    {
      starting_at: last_week[:starting_at] + 7.days,
      ending_at: last_week[:ending_at] + 7.days
    }
  end

  def self.last_week_time_period
    starting_at = Date.today.prev_occurring(:wednesday).beginning_of_day - 7.days + 12.hours
    {
      starting_at: starting_at,
      ending_at: starting_at + 7.days
    }
  end
end
