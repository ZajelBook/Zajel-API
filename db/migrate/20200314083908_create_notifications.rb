class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :content
      t.json :payload
      t.string :recipient_type
      t.integer :recipient_id

      t.timestamps
    end

    add_index :notifications, [:recipient_type, :recipient_id]
  end
end
