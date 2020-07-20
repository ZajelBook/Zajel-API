class AddIsMockToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :is_mock, :boolean, default: false
  end
end
