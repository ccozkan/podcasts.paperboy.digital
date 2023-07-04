class AddBookmarkedAtSecondToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :bookmarked_at_second, :integer, default: 0
  end
end
