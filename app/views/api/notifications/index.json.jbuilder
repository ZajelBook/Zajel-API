json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
  json.count @pagy.count
end
json.notifications do
  json.array! @notifications do |notification|
    json.id notification.id
    json.content notification.content
    json.payload notification.payload
  end
end