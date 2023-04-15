# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  ADMIN_BADGES = {
    'available': 'bg-success',
    'unavailable': 'bg-danger',
    'borrowed': 'bg-warning',
    'accepted': 'bg-success',
    'rejected': 'bg-danger',
    'pending': 'bg-warning'
  }.freeze

  WEB_BADGES = {
    available: 'badge-success',
    unavailable: 'badge-danger',
    borrowed: 'badge-info',
    pending: 'badge-primary',
    accepted: 'badge-success',
    rejected: 'badge-danger'
  }.freeze
end
