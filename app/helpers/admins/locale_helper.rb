# frozen_string_literal: true

module Admins
  module LocaleHelper
    def locale_content(resource, attribute, locale)
      I18n.with_locale(locale) { resource.public_send(attribute) }
    end
  end
end