# frozen_string_literal: true

module Api
  class MockBooksController < ApplicationController
    def index
      @books = Book.where(id: (1..10).to_a.sample(4))
    end
  end
end
