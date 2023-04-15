# frozen_string_literal: true

module Admins
  module BooksHelper
    def book_status(book)
      if book.approved?
        book_availability_badge(book)
      else
        book_approval_status_badge(book)
      end
    end

    def book_approval_status_badge(book)
      badge, content = if book.approved?
                         %w[bg-success Approved]
                       else
                         %w[bg-danger Under Review]
                       end

      tag.span(class: "badge #{badge}") { content }
    end

    def book_availability_badge(book)
      badge = book_badge(book.status)

      tag.span(class: "badge #{badge}") { book.status }
    end

    def book_activity_badge(book)
      badge = book_badge(book.status)

      tag.span(class: "badge #{badge}") { book.status }
    end

    private

    def book_badge(status)
      ApplicationHelper::ADMIN_BADGES[status.to_sym]
    end
  end
end
