# frozen_string_literal: true

json.id @book.id
json.title @book.title
json.author @book.author
json.description @book.description
json.published_at @book.published_at
json.language @book.language
json.page_count @book.page_count
json.image rails_blob_url @book.image if @book.image.present?
json.status @book.status
json.approved @book.approved
json.genre @book.genre.name
json.genre_id @book.genre_id
json.owner_name @book.owner.full_name
json.owner_id @book.owner_id
json.created_at @book.created_at
