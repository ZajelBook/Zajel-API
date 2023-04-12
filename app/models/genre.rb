# frozen_string_literal: true

class Genre < ApplicationRecord
  translates :name

  has_many :books

  accepts_nested_attributes_for :translations, allow_destroy: true
end
