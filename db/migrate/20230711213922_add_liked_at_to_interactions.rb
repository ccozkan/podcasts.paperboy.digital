class AddLikedAtToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :liked_at, :datetime
  end
end
