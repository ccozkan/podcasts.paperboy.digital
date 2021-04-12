class CreateFees < ActiveRecord::Migration[6.1]
  def change
    create_table :fees do |t|
      t.string :rss_url
      t.string :external_id
      t.string :name

      t.timestamps
    end
  end
end
