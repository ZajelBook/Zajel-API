require 'ipinfo'

class GetIpInfoJob < ApplicationJob
  def perform(request_id)
    request = Request.find_by(id: request_id)

    return if request.nil?

    access_token = ENV['IPINFO_TOKEN']
    handler = IPinfo::create(access_token)
    details = handler.details(request.remote_ip)

    country = details.country_name
    city = details.city

    request.update(country: country, city: city)
  end
end