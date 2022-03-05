FactoryBot.define do
  factory :book_activity do
    book { create :approved_book }
    borrower { create :user }

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