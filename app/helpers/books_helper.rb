module BooksHelper
  def book_distance(distance)
    return 'few meters away!' if distance.to_i.eql?(0)

    "#{distance.to_i} km away"
  end

  def book_buttons(book)
    content = if user_signed_in?
                if book.owner == current_user
                  link_to "update book details", edit_book_path(book.id), class: 'genric-btn primary circle arrow'
                else
                  if book.available? && !book.requested_by?(current_user.id)
                    link_to "Send borrow request", book_activities_path(book_id: book.id), data: { turbo_method: :post }, class: 'genric-btn primary circle arrow'
                  elsif book.available? && book.requested_by?(current_user.id)
                    link_to "Cancel borrow request", book_activity_path(book.id), data: { turbo_method: :delete }, class: 'genric-btn primary circle arrow'
                  end
                end
              else
                link_to "Log in", new_user_session_path, class: 'genric-btn primary circle arrow'
              end

    tag.div class: 'text-center mb-20' do
      content
    end
  end

  def book_status_badge(status)
    case status
    when 'available'
      'badge-success'
    when 'unavailable'
      'badge-danger'
    else
      'badge-info'
    end
  end

  def book_status(book)
    if book.approved
      css_class = book_status_badge(book.status)
      content = book.status
    else
      css_class = 'badge-primary'
      content = 'under review'
    end

    tag.div class: "badge #{css_class}", role: 'alert' do
      content
    end
  end
end