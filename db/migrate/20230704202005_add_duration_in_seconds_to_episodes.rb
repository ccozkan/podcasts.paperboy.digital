class AddDurationInSecondsToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :duration_in_seconds, :integer
  end
end
