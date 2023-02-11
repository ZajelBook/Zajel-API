json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
  json.count @pagy.count
end

json.book_activity do
  json.borrower_id @conversation.borrower_id
  json.borrower_type @conversation.borrower_type
  json.borrower_name @conversation.borrower.full_name
  json.lender_id @conversation.lender_id
  json.lender_type @conversation.lender_type
  json.lender_name @conversation.lender.full_name
  json.book_title @book_activity.book.title
end
json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.conversation_id message.conversation_id
    json.content message.content
    json.sender_type message.sender_type
    json.sender_id message.sender_id
    json.sender_name message.sender_name
    json.created_at message.created_at
  end
end
