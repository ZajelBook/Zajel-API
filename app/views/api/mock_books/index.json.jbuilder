json.books @books do |book|
  json.image rails_blob_url book.image if book.image.present?
end