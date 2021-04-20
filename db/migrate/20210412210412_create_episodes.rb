class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.string :external_id
      t.string :audio_url
      t.string :title
      t.text :summary
      t.datetime :published_at
      t.references :feed, null: false, foreign_key: true

      t.timestamps
    end
    add_index :episodes, :external_id, unique: true
  end
end
