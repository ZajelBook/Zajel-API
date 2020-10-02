json.confirmed @confirmed
json.genres do
  json.array! @genres do |genre|
    json.id genre.id
    json.name genre.name
  end
end

json.languages do
  json.array! @languages
end