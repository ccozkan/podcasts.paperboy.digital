class RemoveDurationFromEpisodes < ActiveRecord::Migration[7.0]
  def change
    remove_column :episodes, :duration, :string
  end
end
