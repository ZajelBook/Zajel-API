require 'faker'

1.upto(10) do
  User.create!(
      email: Faker::Internet.email,
      password: '12345678',
      password_confirmation: '12345678',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 40),
      phone_number: Faker::PhoneNumber.cell_phone
  )
end

1.upto(5) do
  Genre.create!(
      name: Faker::Book.genre
  )
end

1.upto(30) do
  Book.create!(
      title: Faker::Book.title,
      description: 'seeded data',
      author: Faker::Book.author,
      published_at: Faker::Date.between(from: 15.years.ago, to: Date.today),
      language: 'English',
      page_count: rand(100..500),
      genre_id: rand(1..5),
      user_id: rand(3..10)
  )
end


