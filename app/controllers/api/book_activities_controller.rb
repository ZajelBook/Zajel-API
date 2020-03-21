module Api
  class BookActivitiesController < ApplicationController
    before_action :authenticate_user!

    def index
      book_activities = if params[:type].eql?('sent')
                           current_user.borrow_requests
                         elsif params[:type].eql?('received')
                           current_user.lend_requests
                         end.includes(:borrower, :lender, book: [:genre, image_attachment: :blob]).order(created_at: :desc)

      @pagy, @book_activities = pagy(book_activities, items: params[:per_page])
    end

    def create
      book_activity = current_user.borrow_requests.new(book_activity_params)
      if book_activity.save
        render json: {status: 'request sent successfully'}
      else
        @error_message = book_activity.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    def update

    end

    def destroy
      book_activity = current_user.borrow_requests.find(params[:id])
      if book_activity.destroy
        render json: {status: 'requests cancelled successfully'}
      else
        @error_message = book_activity.errors
        render 'shared/errors', status: :unprocessable_entity
      end
    end

    private
    def book_activity_params
      params.permit(:book_id)
    end
  end
end