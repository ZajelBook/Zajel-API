# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    def index
      @users = User.all.order(created_at: :desc)
      @pagy, @users = pagy(@users, items: params[:per_page])
    end

    def show
      @user = User.find(params[:id])
      @books = @user.books.includes(image_attachment: :blob).order(created_at: :desc)
      @borrow_requests = @user.borrow_requests.includes(book: [image_attachment: :blob]).order(created_at: :desc)
    end
  end
end
