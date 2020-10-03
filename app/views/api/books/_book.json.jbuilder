json.id book.id
json.title book.title
json.author book.author
json.description book.description
json.published_at book.published_at
json.language book.display_language
json.page_count book.page_count
json.image rails_blob_url book.image if book.image.present?
json.status I18n.t("book.status.#{book.status}")
json.approved book.approved
json.genre book.genre.name
json.genre_id book.genre_id
json.owner_type book.owner_type
json.owner_id book.owner_id
json.friendly_id book.slug
json.is_mock book.is_mock
json.distance book.try(:distance) ? book.distance.to_i : @distance.to_i
json.requested book.requested_by?(current_user.id) if user_signed_in? && book.owner != current_user