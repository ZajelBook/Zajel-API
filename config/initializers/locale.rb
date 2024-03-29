# frozen_string_literal: true

# Permitted locales available for the application
I18n.available_locales = %i[en ar]

# Set default locale to something other than :en
I18n.default_locale = :en

I18n.fallbacks = [:en]
