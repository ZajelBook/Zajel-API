# frozen_string_literal: true

set :stage, :staging

server '178.128.48.113', user: 'mylestone', roles: %w[web app db]
