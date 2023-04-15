# frozen_string_literal: true
module Admins
  module UsersHelper
    def user_verification_badge(user)
      badge_class = user.confirmed_at? ? 'bg-success' : 'bg-danger'
      content = user.verified? ? 'Yes' : 'No'
      tag.span(class: "badge #{badge_class}") { content }
    end
  end
end
