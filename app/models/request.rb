class Request < ApplicationRecord
  after_create_commit :get_ip_info

  def get_ip_info
    GetIpInfoJob.perform_async(self.id)
  end
end
