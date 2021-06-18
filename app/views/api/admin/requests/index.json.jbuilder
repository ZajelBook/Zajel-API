json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
  json.count @pagy.count
end
json.requests do
  json.array! @requests do |request|
    json.id request.id
    json.user_email request.user_email
    json.remote_ip request.remote_ip
    json.controller_class request.controller_class
    json.original_path request.original_path
    json.method request.method
    json.created_at request.created_at
  end
end