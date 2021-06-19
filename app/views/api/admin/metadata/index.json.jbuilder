json.metadata do
  json.users_count @users_count
  json.books_count @books_count
  json.requests_count @requests_count
  json.conversations_count @conversations_count

  json.request_per_day_count @request_per_day_count do |date, count|
    json.date date
    json.count count
  end

  json.request_per_country_count @request_per_country_count do |country, count|
    json.date country
    json.count count
  end
end