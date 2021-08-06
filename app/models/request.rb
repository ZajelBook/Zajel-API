class Request < ApplicationRecord
  after_create_commit :get_ip_info

  def get_ip_info
    GetIpInfoJob.perform_later(self.id)
  end
end
