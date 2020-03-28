require 'faker'

1.upto(10) do
  User.create!(
      email: Faker::Internet.email,
      password: '00000000',
      password_confirmation: '00000000',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      birth_date: Faker::Date.birthday(min_age: 18, max_age: 40),
      phone_number: Faker::PhoneNumber.cell_phone
  )
end

User.create!(
    email: 'mrahmoun93@gmail.com',
    password: '00000000',
    password_confirmation: '00000000',
    first_name: 'Mohamad',
    last_name: 'Rahmoun',
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 40),
    phone_number: Faker::PhoneNumber.cell_phone
)

User.create!(
    email: 'dr.rich4444@gmail.com',
    password: '00000000',
    password_confirmation: '00000000',
    first_name: 'Mohamad',
    last_name: 'Mokresh',
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 40),
    phone_number: Faker::PhoneNumber.cell_phone
)

1.upto(7) do
  Genre.create!(
      name: Faker::Book.genre
  )
end

covers = ["https://marketplace.canva.com/MACXC0twKgo/1/0/thumbnail_large/canva-green-and-pink-science-fiction-book-cover-MACXC0twKgo.jpg",
 "https://emusdebuts.files.wordpress.com/2018/04/the-benefits-of-being-an-octopus.jpg?w=341&h=512",
 "https://marketplace.canva.com/MAB___U-clw/1/0/thumbnail_large/canva-yellow-lemon-children-book-cover-MAB___U-clw.jpg",
 "https://marketplace.canva.com/MACQe2BV5K8/3/0/thumbnail_large/canva-yellow-with-palm-leaves-summer-camp-flyer-MACQe2BV5K8.jpg",
 "https://marketplace.canva.com/MACXJdNnuMc/2/0/thumbnail_large/canva-white-graphic-design-book-cover-MACXJdNnuMc.jpg",
 "https://marketplace.canva.com/MAB-xp1e6RQ/1/0/thumbnail_large/canva-children%27s-stars-and-moon-poster-MAB-xp1e6RQ.jpg",
 "https://about.canva.com/wp-content/uploads/sites/3/2015/01/children_bookcover.png",
 "https://dwtr67e3ikfml.cloudfront.net/bookCovers/f66daf6bed6a59c30cdea705df3ca750d5450ea3",
 "https://about.canva.com/wp-content/uploads/sites/3/2015/01/creative_bookcover.png",
 "https://qph.fs.quoracdn.net/main-qimg-69d1ed4b453150cefd182acfd038cda8",
 "https://marketplace.canva.com/MACW95yYky0/1/0/thumbnail_large/canva-bright-red-and-yellow-illustrated-pencil-graphic-design-book-cover-MACW95yYky0.jpg"
]

1.upto(30) do
  url = covers[rand(0..10)]
  filename = File.basename(URI.parse(url).path)
  file = URI.open(url)
  book = Book.new(
      title: Faker::Book.title,
      description: 'seeded data',
      author: Faker::Book.author,
      published_at: (1950..2000).to_a.sample.to_s,
      language: Language.pluck(:name).sample,
      approved: true,
      page_count: rand(100..500),
      genre_id: Genre.pluck(:id).sample,
      owner_type: 'User',
      owner_id: User.pluck(:id).sample
  )
  book.image.attach(io: file, filename: filename)
  book.save!
end

Language.create([{name: 'English'},
                 {name: 'Arabic'},
                 {name: 'French'}])

1.upto(10) do
  book_id = User.find(11).books.ids.sample
  book = Book.find(book_id)
  borrower_id = User.ids.sample
  BookActivity.create(book: book,
                      borrower_id: borrower_id,
                      borrower_type: 'User')
end

1.upto(10) do
  book_id = User.find(12).books.ids.sample
  book = Book.find(book_id)
  borrower_id = User.ids.sample
  BookActivity.create(book: book,
                      borrower_id: borrower_id,
                      borrower_type: 'User')
end
