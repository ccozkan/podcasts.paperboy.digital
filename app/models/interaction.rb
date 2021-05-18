class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  validates_uniqueness_of :user_id, scope: :episode_id

  def self.dismiss_an_episode(episode_id, user_id)
    Interaction.create(dismissed: true, episode_id: episode_id, user_id: user_id)
  end
end
