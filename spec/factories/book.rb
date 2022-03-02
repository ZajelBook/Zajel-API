FactoryBot.define do
  factory :book do
    owner { build :user }
    genre { build :genre }
    title { 'Book Title' }
    author  { 'Book Author' }
    description  { 'Book Description goes here' }
    published_at { (Date.today - 20.years).to_s }
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
      status { 'approved' }
    end

    factory :approved_book, traits: [:available, :approved]
    factory :unavailable_book, traits: [:unavailable, :approved]
    factory :borrowed_book, traits: [:borrowed, :approved]
  end
end