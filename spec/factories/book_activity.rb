FactoryBot.define do
  factory :book_activity do
    book { build :approved_book }
    borrower { build :user }
    lender { build :user }

    trait :accepted do
      status { 'accepted' }
    end

    trait :rejected do
      status { 'rejected' }
    end


    factory :accepted_request, traits: [:accepted]
    factory :rejected_request, traits: [:rejected]
  end
end