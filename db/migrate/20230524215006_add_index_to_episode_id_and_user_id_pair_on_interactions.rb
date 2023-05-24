class AddIndexToEpisodeIdAndUserIdPairOnInteractions < ActiveRecord::Migration[7.0]
  def change
    add_index :interactions, [:user_id, :episode_id], unique: true
  end
end
