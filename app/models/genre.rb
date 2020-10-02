class Genre < ApplicationRecord
  translates :name

  has_many :books
end
