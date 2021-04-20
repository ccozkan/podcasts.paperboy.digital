class AddLastPublishedAtToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :last_published_at, :datetime
  end
end
