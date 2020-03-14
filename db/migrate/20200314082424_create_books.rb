class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.date :published_at
      t.string :language
      t.integer :page_count
      t.string :image
      t.integer :status, default: 0
      t.boolean :approved, default: false
      t.references :user, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
