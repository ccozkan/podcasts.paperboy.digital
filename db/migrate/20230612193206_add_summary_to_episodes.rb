class AddSummaryToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :summary, :text
  end
end
