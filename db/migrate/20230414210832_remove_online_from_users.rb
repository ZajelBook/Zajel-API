class RemoveOnlineFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :online, :boolean
  end
end
