class AddListenItLateredAtToInteractions < ActiveRecord::Migration[7.0]
  def change
    add_column :interactions, :listen_it_latered_at, :datetime
  end
end
