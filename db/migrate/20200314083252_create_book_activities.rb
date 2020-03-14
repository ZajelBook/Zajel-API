class CreateBookActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :book_activities do |t|
      t.references :book, null: false, foreign_key: true
      t.string :borrower_type
      t.integer :borrower_id
      t.string :lender_type
      t.integer :lender_id
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :book_activities, [:borrower_type, :borrower_id]
    add_index :book_activities, [:lender_type, :lender_id]
  end
end
