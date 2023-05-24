# == Schema Information
#
# Table name: interactions
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  episode_id :bigint           not null
#  dismissed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  validates_uniqueness_of :user_id, scope: :episode_id

  def self.dismiss_an_episode(episode_id, user_id)
    Interaction.create!(dismissed: true, episode_id:, user_id:)
  end

  def self.star_or_unstar_an_episode!(episode_id, user_id)
    interaction = Interaction.find_or_initialize_by(episode_id: episode_id,
                                                    user_id: user_id)

    interaction.starred_at = if interaction.starred_at?
                               nil
                             else
                               interaction.starred_at = Time.current
                             end
    interaction.save!
  end
end
