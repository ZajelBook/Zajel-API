# frozen_string_literal: true

module BookActivitiesHelper
  def lend_request_status(status)
    badge = status_badge(status)

    tag.div class: "badge #{badge}", role: 'alert' do
      status
    end
  end

  def borrow_request_status(status)
    badge = status_badge(status)

    tag.div class: "badge #{badge}", role: 'alert' do
      status
    end
  end

  def status_badge(status)
    case status
    when 'pending'
      'badge-primary'
    when 'accepted'
      'badge-success'
    when 'rejected'
      'badge-danger'
    end
  end
end
