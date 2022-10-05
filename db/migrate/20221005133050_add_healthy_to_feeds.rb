class AddHealthyToFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :healthy, :boolean
  end
end
