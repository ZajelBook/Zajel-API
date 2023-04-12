# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    owner { create :user }
    genre { create :genre }
    title { 'Book Title' }
    author  { 'Book Author' }
    description  { 'Book Description goes here' }
    published_at { (Date.current - 20.years).to_s }
    language { 'English' }
    page_count { 423 }

    trait :available do
      status { 'available' }
    end

    trait :unavailable do
      status { 'unavailable' }
    end

    trait :borrowed do
      status { 'borrowed' }
    end

    trait :approved do
      approved { true }
    end

    factory :approved_book, traits: %i[available approved]
    factory :unavailable_book, traits: %i[unavailable approved]
    factory :borrowed_book, traits: %i[borrowed approved]
  end
end
