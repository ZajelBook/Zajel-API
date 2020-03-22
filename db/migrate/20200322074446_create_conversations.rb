class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.string :borrower_type
      t.integer :borrower_id
      t.string :lender_type
      t.integer :lender_id

      t.timestamps
    end
  end
end
