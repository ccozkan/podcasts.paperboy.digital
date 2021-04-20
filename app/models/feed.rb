class Feed < ApplicationRecord
  has_many :episodes

  validates_presence_of :external_id
  validates_uniqueness_of :external_id
end
