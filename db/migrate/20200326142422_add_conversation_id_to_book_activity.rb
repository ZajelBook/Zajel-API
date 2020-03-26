class AddConversationIdToBookActivity < ActiveRecord::Migration[6.1]
  def change
    add_reference :book_activities, :conversation, foreign_key: true
  end
end
