# frozen_string_literal: true

class BookActivityNotificationJob < ApplicationJob
  def perform(book_activity_id, method)
    book_activity = BookActivity.find_by(id: book_activity_id)

    return unless book_activity

    book_activity.send(method)
  end
end
