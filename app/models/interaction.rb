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

  class << self
    def dismiss!(episode_id, user_id)
      find_or_initialize_interaction(episode_id, user_id)
      @interaction.dismissed = true
      @interaction.save!
    end

    def bookmark!(episode_id, user_id, bookmark_time)
      find_or_initialize_interaction(episode_id, user_id)
      @interaction.bookmarked_at_second = bookmark_time
      @interaction.save!
      @interaction
    end

    def toggle_from_listen_it_later!(episode_id, user_id)
      find_or_initialize_interaction(episode_id, user_id)
      @interaction.listen_it_latered_at = if @interaction.listen_it_latered_at?
                                            nil
                                          else
                                            @interaction.listen_it_latered_at = Time.current
                                          end
      @interaction.save!
    end

    def bookmarked_second(episode_id, user_id)
      find_interaction(episode_id, user_id)
      @interaction&.bookmarked_at_second || nil
    end

    def bookmarked_at_pretty_time(episode_id, user_id)
      find_interaction(episode_id, user_id)
      Time.at(@interaction.bookmarked_at_second).utc.strftime("%H:%M:%S") if @interaction
    end

    def find_interaction(episode_id, user_id)
      @interaction = Interaction.find_by(episode_id:,
                                         user_id:)
    end

    private

    def find_or_initialize_interaction(episode_id, user_id)
      @interaction = Interaction.find_or_initialize_by(episode_id:,
                                                       user_id:)
    end
  end
end
