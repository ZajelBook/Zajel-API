# frozen_string_literal: true

module Admins
  class BooksController < ApplicationController
    before_action :set_book, only: %i[show edit update approve mark_as_unavailable mark_as_available]

    def index
      scope = Book.approved
      scope = Book.waiting_approval if params[:type].present? && params[:type].eql?('new')
      @books = scope.includes(:owner).order(created_at: :desc)
      @pagy, @books = pagy(@books, items: params[:per_page])
    end

    def show; end

    def edit; end

    def update
      if @book.update(book_params)
        redirect_to admins_book_path(@book.id)
      else
        render :edit
      end
    end

    def approve
      return unless @book.update(approved: true)

      redirect_to admins_book_path(@book.id)
    end

    def mark_as_unavailable
      return unless @book.update(status: :unavailable)

      redirect_to admins_book_path(@book.id)
    end

    def mark_as_available
      return unless @book.update(status: :available)

      redirect_to admins_book_path(@book.id)
    end

    private

    def book_params
      params.require(:book).permit(:title, :author, :description, :language, :image, :genre_id, :approved, :status)
    end

    def set_book
      @book = Book.find(params[:id])
    end
  end
end
