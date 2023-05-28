class AddDurationToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :duration, :string
  end
end
