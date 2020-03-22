json.id book.id
json.title book.title
json.author book.author
json.description book.description
json.published_at book.published_at
json.language book.language
json.page_count book.page_count
json.image rails_blob_url book.image
json.status book.status
json.approved book.approved
json.genre book.genre.name
json.owner_type book.owner_type
json.owner_id book.owner_id
json.requested book.requested_by?(current_user.id)