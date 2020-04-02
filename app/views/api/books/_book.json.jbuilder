json.id book.id
json.title book.title
json.author book.author
json.description book.description
json.published_at book.published_at
json.language book.language
json.page_count book.page_count
json.image rails_blob_url book.image if book.image.present?
json.status book.status
json.approved book.approved
json.genre book.genre.name
json.genre_id book.genre_id
json.owner_type book.owner_type
json.owner_id book.owner_id
json.friendly_id book.slug
if @nearby_users.present?
  json.distance @nearby_users.find {|user| book.owner.id.eql?(user.id)}.distance.to_i
else
  json.distance @distance.to_i
end
json.requested book.requested_by?(current_user.id) if user_signed_in? && book.owner != current_user