class AddLastCheckErrorToFeeds < ActiveRecord::Migration[6.1]
  def change
    add_column :feeds, :last_check_error, :text
  end
end
