class AddColumnsToRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :country, :string
    add_column :requests, :city, :string
  end
end
