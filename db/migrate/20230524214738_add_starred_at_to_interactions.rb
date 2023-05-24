class AddStarredAtToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :starred_at, :datetime
  end
end
