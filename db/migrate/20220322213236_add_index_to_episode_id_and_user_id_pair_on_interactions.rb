class AddIndexToEpisodeIdAndUserIdPairOnInteractions < ActiveRecord::Migration[6.1]
  def change
    add_index :interactions, [:user_id, :episode_id], unique: true
  end
end
