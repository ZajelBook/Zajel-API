# frozen_string_literal: true

set :stage, :production

server '62.113.255.78', user: 'ubuntu', roles: %w[web app db]
