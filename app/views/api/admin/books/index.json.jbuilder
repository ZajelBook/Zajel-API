json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
  json.count @pagy.count
end
json.books do
  json.array! @books do |book|
    json.id book.id
    json.title book.title
    json.status book.status
    json.approved book.approved
    json.owner_name book.owner.full_name
  end
end