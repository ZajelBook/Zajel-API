class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.string :user_email
      t.string :remote_ip
      t.string :controller_class
      t.string :original_path
      t.string :method

      t.timestamps
    end
  end
end
