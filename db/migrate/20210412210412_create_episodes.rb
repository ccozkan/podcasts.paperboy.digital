class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.string :media_url
      t.string :title
      t.text :body
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
