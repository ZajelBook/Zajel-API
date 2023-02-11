json.id @user.id
json.email @user.email
json.name @user.full_name
json.birth_date @user.birth_date
json.phone_number @user.phone_number
json.created_at @user.created_at
json.online @user.online
json.confirmed @user.confirmed_at.present?
json.latitude @user.latitude
json.longitude @user.longitude
json.mobile @user.fcm_token.present?

json.books do
  json.array! @books do |book|
    json.id book.id
    json.title book.title
    json.image rails_blob_url book.image if book.image.present?
    json.created_at book.created_at
  end
end

json.borrow_requests do
  json.array! @borrow_requests do |borrow_request|
    json.book_id borrow_request.book.id
    json.book_title borrow_request.book.title
    json.book_image rails_blob_url borrow_request.book.image if borrow_request.book.image.present?
    json.created_at borrow_request.created_at
    json.status borrow_request.status
  end
end
