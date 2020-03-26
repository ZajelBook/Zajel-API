class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :sender_type
      t.integer :sender_id
      t.string :receiver_type
      t.integer :receiver_id
      t.text :content
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end

    add_index :messages, [:sender_type, :sender_id]
    add_index :messages, [:receiver_type, :receiver_id]
  end
end
