json.books do
  json.partial! 'api/books/book', collection: @books, as: :book
end