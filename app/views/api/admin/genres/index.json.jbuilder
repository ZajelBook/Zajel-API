# frozen_string_literal: true

json.genres do
  json.array! @genres do |genre|
    json.id genre.id
    json.name genre.name
  end
end
