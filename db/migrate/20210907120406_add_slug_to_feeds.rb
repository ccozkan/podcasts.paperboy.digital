class AddSlugToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :slug, :string
    add_index :feeds, :slug, unique: true
  end
end
