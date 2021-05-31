class RemoveSummaryFromEpisodes < ActiveRecord::Migration[6.1]
  def change
    remove_column :episodes, :summary, :text
  end
end
