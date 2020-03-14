json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
end
json.books @books, partial: 'api/books/book', as: :book