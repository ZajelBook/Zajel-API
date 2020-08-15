module Api
  class MockBooksController < ApplicationController
    skip_before_action :check_user_confirmation_status, only: [:index, :show]

    def index
      @books = Book.where(id: (1..10).to_a.sample(4))
    end

  end
end
