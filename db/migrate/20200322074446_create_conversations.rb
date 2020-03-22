class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.string :borrower_type
      t.integer :borrower_id
      t.string :lender_type
      t.integer :lender_id

      t.timestamps
    end

    add_index :conversations, [:borrower_type, :borrower_id]
    add_index :conversations, [:lender_type, :lender_id]
  end
end
