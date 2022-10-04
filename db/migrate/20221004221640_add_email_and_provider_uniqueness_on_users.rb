class AddEmailAndProviderUniquenessOnUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:email, :provider], unique: true
  end
end
