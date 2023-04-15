# frozen_string_literal: true

module Web
  module BookActivitiesHelper
    def book_activity_status(status)
      badge = ApplicationHelper::WEB_BADGES[status.to_sym]

      tag.div(class: "badge #{badge}", role: 'alert') { status }
    end
  end
end