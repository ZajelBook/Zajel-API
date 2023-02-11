json.metadata do
  json.total_pages @pagy.pages
  json.current_page @pagy.page
  json.per_page @pagy.items
  json.count @pagy.count
end
json.users do
  json.array! @users do |user|
    json.id user.id
    json.email user.email
    json.full_name user.full_name
    json.phone_number user.phone_number
    json.confirmed user.confirmed_at.present?
    json.created_at user.created_at
  end
end
