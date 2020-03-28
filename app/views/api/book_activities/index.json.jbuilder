json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
end
json.book_activities do
  json.array! @book_activities do |book_activity|
    json.id book_activity.id
    json.status book_activity.status
    json.conversation_id book_activity.conversation_id
    json.borrower do
      json.id book_activity.borrower.id
      json.name book_activity.borrower.full_name
    end
    json.lender do
      json.id book_activity.lender.id
      json.name book_activity.lender.full_name
    end
    json.book do
      json.partial! book_activity.book
    end
  end
end