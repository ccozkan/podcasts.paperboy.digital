class AddStarredToInteractions < ActiveRecord::Migration[6.1]
  def change
    add_column :interactions, :starred, :boolean, default: false
  end
end
