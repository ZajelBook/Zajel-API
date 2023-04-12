# frozen_string_literal: true

module AdminsHelper
  def user_verification_badge(user)
    badge = case user.confirmed_at?
            when false
              'bg-danger'
            when true
              'bg-success'
            end

    content = user.verified? ? 'Yes' : 'No'

    tag.span class: "badge #{badge}" do
      content
    end
  end

  def book_status(book)
    if book.approved?
      book_availability_badge(book)
    else
      book_approval_status_badge(book)
    end
  end

  def book_approval_status_badge(book)
    badge = case book.approved?
            when false
              'bg-danger'
            when true
              'bg-success'
            end

    content = book.approved? ? 'Approved' : 'Under Review'

    tag.span class: "badge #{badge}" do
      content
    end
  end

  def book_availability_badge(book)
    badge = case book.status
            when 'available'
              'bg-success'
            when 'unavailable'
              'bg-danger'
            when 'borrowed'
              'bg-warning'
            end

    tag.span class: "badge #{badge}" do
      book.status
    end
  end

  def book_activity_badge(book)
    badge = case book.status
            when 'accepted'
              'bg-success'
            when 'rejected'
              'bg-danger'
            when 'pending'
              'bg-warning'
            end

    tag.span class: "badge #{badge}" do
      book.status
    end
  end

  def locale_content(resource, attribute, locale)
    I18n.with_locale(locale) do
      resource.public_send(attribute)
    end
  end
end
