# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Test' }
    last_name  { 'User' }
    email { "test_#{User.count + 1}@zajelbook.com" }
    password { '12345678' }
    birth_date { Date.current - 20.years }
    locale { 'en' }
    latitude { '50.110924' }
    longitude { '8.682127' }
    phone_number { '+49157345285738' }

    trait :verified do
      verified { true }
    end

    factory :verified_user, traits: [:verified]
  end
end
