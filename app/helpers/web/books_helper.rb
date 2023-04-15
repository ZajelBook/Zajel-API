# frozen_string_literal: true

module Web
  module BooksHelper
    def book_distance(distance)
      return 'few meters away!' if distance.to_i.eql?(0)

      "#{distance.to_i} km away"
    end

    def book_buttons(book)
      content = if user_signed_in?
                  if book.owner == current_user
                    link_to 'Update', edit_book_path(book.id), class: 'genric-btn btn-block danger circle'
                  elsif book.available? && !book.requested_by?(current_user.id)
                    link_to 'Request', book_activities_path(book_id: book.id), data: { turbo_method: :post },
                            class: 'genric-btn btn-block danger circle'
                  elsif book.available? && book.requested_by?(current_user.id)
                    link_to 'Cancel request', book_activity_path(book.id), data: { turbo_method: :delete },
                            class: 'genric-btn btn-block danger circle'
                  end
                else
                  link_to 'Log in', new_user_session_path, class: 'genric-btn btn-block danger circle'
                end

      tag.div(class: 'text-center mb-20') { content }
    end

  def book_status(book)
    if book.approved
      css_class = ApplicationHelper::WEB_BADGES[book.status.to_sym]
      content = book.status
    else
      css_class = 'badge-primary'
      content = 'under review'
    end

      tag.div(class: "badge #{css_class}", role: 'alert') { content }
    end
  end
end
