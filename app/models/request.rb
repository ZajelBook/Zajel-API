# frozen_string_literal: true

class Request < ApplicationRecord
  after_create_commit :get_ip_info

  def get_ip_info
    GetIpInfoJob.perform_later(id)
  end
end
