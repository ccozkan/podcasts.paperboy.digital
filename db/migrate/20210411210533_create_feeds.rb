class CreateFeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :feeds do |t|
      t.string :rss_url
      t.string :pic_url
      t.string :external_id
      t.string :provider
      t.string :name

      t.timestamps
    end
    add_index :feeds, :external_id, unique: true
  end
end
