class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.date :published_at
      t.string :language
      t.integer :page_count
      t.integer :status, default: 0
      t.boolean :approved, default: false
      t.string :owner_type
      t.integer :owner_id
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end

    add_index :books, [:owner_type, :owner_id]
  end
end
